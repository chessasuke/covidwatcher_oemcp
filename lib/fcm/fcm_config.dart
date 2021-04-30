import 'package:covid_watcher/controllers/navigator_controller.dart';
import 'package:covid_watcher/models/fcm_notification_model.dart';
import 'package:covid_watcher/providers/notifications_providers.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/cupertino.dart';

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
  static Future<void> initializeFCM(BuildContext context) async {
    print('initializing FCM');

    /// Set foreground messaging handler (THESE ARE IN-APP NOTIFICATIONS)
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('onMessage triggered');
      if (message != null) {
        print('msg id: ${message.messageId}');
        RemoteNotification notification = message.notification;
        AndroidNotification android = message.notification?.android;

        /// For android
        if (notification != null && android != null) {
          /// Add notification to the notification list provider and navigate to the notification screen
          if (message.messageId != null) {
            /// Construct a notification model
            String title = message.notification?.title;
            FcmNotificationModel fcmNotificationModel = FcmNotificationModel(
                id: message.messageId,
                title: title,
                time: message.sentTime.toString());

            /// Add the new notification to the provider notification list
            var temp = context.read(fcmNotificationListProvider);
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
//              PageManager.of(context).addNotificationScreen(message.messageId!);
          }
        }
      }
    });

    /// handle any interaction when the app is in the background via Stream listener
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('onMessageOpenedApp triggered');
      if (message != null) {
        print(message.data.keys);
        RemoteNotification remoteNotification = message.notification;
        String title = remoteNotification?.title;

        /// Construct a notification model
        FcmNotificationModel fcmNotificationModel = FcmNotificationModel(
            id: message.messageId,
            title: title,
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

    print('initial msg ID: ${initialMessage?.messageId}');

    /// Get info from the message and construct a FSM_Notification Model
    if (initialMessage != null) {
      if (initialMessage != null) {
        if (initialMessage.data['type'] == 'type1') {
          print(
              'onMessageOpenedApp intial msg: ${initialMessage.data['type']}');
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
        } else {
          print('no data msg');
        }
      }
    }
  }
}
