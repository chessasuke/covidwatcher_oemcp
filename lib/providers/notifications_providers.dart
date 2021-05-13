import 'package:covid_watcher/models/fcm_notification_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// THIS FILE CONTAINS PROVIDERS CONNECTED TO THE NOTIFICATIONS MODULE

/// To check if Favorite Widget is expanded or collapsed
final isFavoritesOpen = StateProvider<bool>((ref) => false);

/// To check if FCM Notifications Widget is expanded or collapsed
final isNotificationsOpen = StateProvider<bool>((ref) => false);

/// Handle the state of the list of buildings to show in the notification module's search bar
final buildingsResults = StateProvider<List<String>>((ref) => []);

/// manages state of the List of notifications received from FCM (Firebase Cloud Messaging)
final fcmNotificationListProvider =
    StateProvider<List<FcmNotificationModel>>((ref) => [
          /// Initialize an example notification
//          FcmNotificationModel(
//              id: 'some_random_id_this_is_an_example',
//              title: 'Example Notification1',
//              body: 'The body here',
//              time: DateTime.now().toString())
        ]);

/// to provide a notification based on a given ID
final fcmNotificationProvider =
    Provider.family<FcmNotificationModel, String>((ref, String id) {
  final list = ref.watch(fcmNotificationListProvider).state;
  final FcmNotificationModel notification =
      list.firstWhere((element) => element.id == id);
  return notification;
});
