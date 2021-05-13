import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid_watcher/services_controller/local_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/navigator_controller.dart';
import '../models/fcm_notification_model.dart';
import '../providers/notifications_providers.dart';

/// FCM CONTROLLER - this file has the logic to handle
/// the Firebase Cloud Messaging (FCM), basically the Push Notifications
/// There are 3 types states to manage, when the app is open and the user is
/// inside the app, when the app is in the background, and when the app is terminated

/// Define a top-level named handler which background/terminated messages will call.
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
}

/// Create a [AndroidNotificationChannel] for heads up notifications
/// Needed for receive notification while inside the app
const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  'This channel is used for important notifications.', // description
  importance: Importance.max,
);

/// Plugin for local notifications
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class FcmService {
  /// Subscribe to topic, buildings in this case
  /// will allow the user to receive notifications in realtime for that building
  static Future<bool> subscribeToTopic(String topic) async {
    if (topic != null && topic.isNotEmpty) {
      topic =
          topic.replaceAll(' ', '_').replaceAll('(', '').replaceAll(')', '');
      print('subscribing to $topic');
      try {
        await FirebaseMessaging.instance.subscribeToTopic(topic);
        return true;
      } catch (e) {
        print('error subscribing to topic: $e');
        return false;
      }
    } else {
      print('invalid topic');
      return false;
    }
  }

  /// Unubscribe from buildings,
  /// stop receiving push notificatoins from that buildings
  static Future<bool> unsubscribeFromTopic(String topic) async {
    try {
      await FirebaseMessaging.instance.unsubscribeFromTopic(topic);
      return true;
    } catch (e) {
      print('error un-subscribing from topic: $e');
      return false;
    }
  }

  static Future<void> saveTokenToDatabase(String token) async {
    String userId = FirebaseAuth.instance.currentUser.uid;
    if (userId != null) {
      await FirebaseFirestore.instance.collection('users').doc(userId).update({
        'tokens': FieldValue.arrayUnion([token]),
      });
    }
  }

  /// Get token and store it in the DB
  /// if token gets refreshed get the new token
  static Future<void> manageTokens() async {
    String userId = FirebaseAuth.instance.currentUser.uid;
    if (userId != null) {
      String token = await FirebaseMessaging.instance.getToken();
      // Save the initial token to the database
      await saveTokenToDatabase(token);
      // Any time the token refreshes, store this in the database too.
      FirebaseMessaging.instance.onTokenRefresh.listen(saveTokenToDatabase);
    }
  }

  static Future<bool> requestPermission() async {
    NotificationSettings notificationSettings =
        await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    print(
        'User granted permission: ${notificationSettings.authorizationStatus}');
    if (notificationSettings.authorizationStatus ==
        AuthorizationStatus.authorized) {
      print('authorize');
      return true;
    } else {
      print('no authorization');
      return false;
    }
  }

  static Future<String> subscribeTopicsAfterWebPermission() async {
    String statusCode = 'ok';
    List<String> sub = await getNotifierBuildings();
    if (sub != null && sub.isNotEmpty) {
      try {
        await Future.forEach(sub, subscribeToTopic);
      } catch (e) {
        statusCode = 'error';
        print(e);
      }
    }
    return statusCode;
  }

  static Future<void> initializeFCM(BuildContext context) async {
    print('initializing FCM');

    /// On initialization subscribe to general topic
    /// to receive broadcast-notifications
    await subscribeToTopic('broadcast');

    /// Set foreground messaging handler (THESE ARE IN-APP NOTIFICATIONS)
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('onMessage triggered');
      if (message != null) {
        RemoteNotification notification = message.notification;

        /// Add notification to the notification list provider
        /// and navigate to the notification screen
        if (message.messageId != null) {
          /// For android
//        AndroidNotification android = message.notification?.android;
//        if (notification != null && android != null) {
          String title;
          String body;
          if (notification != null) {
            /// Construct a notification model
            title = message.notification.title ?? 'Notification';
            body = message.notification.body ?? '';
          }
          FcmNotificationModel fcmNotificationModel = FcmNotificationModel(
              id: message.messageId,
              title: title,
              body: body,
              time: message.sentTime.toString());

          /// Add the new notification to the provider notification list
          final temp = context.read(fcmNotificationListProvider);
          temp.state = [...temp.state, fcmNotificationModel];
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor:
                  Theme.of(context).backgroundColor.withOpacity(0.7),
              elevation: 40,
              content: TextButton(
                  onPressed: () {
                    NavigatorController.of(context)
                        .addNotificationScreen(message.messageId);
                  },
                  child: Text(title ?? 'Notification'))));
        } else {
          print('error: msg doesnt have id');
        }
      }
    });

    /// handle any interaction when the app is in the background via Stream listener
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('onMessageOpenedApp triggered');
      if (message != null) {
        RemoteNotification remoteNotification = message.notification;
        String title = remoteNotification.title ?? 'Notification';
        String body = remoteNotification.body ?? '';

        /// Construct a notification model
        FcmNotificationModel fcmNotificationModel = FcmNotificationModel(
            id: message.messageId,
            title: title,
            body: body,
            time: message.sentTime.toString());

        /// Add the new notification to the provider notification list
        var temp = context.read(fcmNotificationListProvider);
        temp.state = [...temp.state, fcmNotificationModel];
        print('going to msg id page');

        /// Navigate to the notification screen by passing the id
        NavigatorController.of(context)
            .addNotificationScreen(message.messageId);
      }
    });

    /// Get any messages which caused the application to open from a terminated state.
    final RemoteMessage initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    /// Get info from the message and construct a FSM_Notification Model
    if (initialMessage != null) {
      print('onMessageOpenedApp intial msg: ${initialMessage.data['type']}');
      RemoteNotification remoteNotification = initialMessage.notification;
      String title = remoteNotification?.title;

      /// Construct a notification model
      FcmNotificationModel fcm_notificationModel = FcmNotificationModel(
          id: initialMessage.messageId,
          title: title,
          time: initialMessage.sentTime.toString());

      /// Add the new notification to the provider notification list
      var temp = context.read(fcmNotificationListProvider);
      temp.state = [...temp.state, fcm_notificationModel];

      /// Navigate to the notification screen by passing the id
      NavigatorController.of(context)
          .addNotificationScreen(initialMessage.messageId);
    }
  }
}
