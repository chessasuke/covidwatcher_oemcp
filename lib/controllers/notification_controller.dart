import 'package:covid_watcher/services_controller/fcm_services.dart';
import 'package:covid_watcher/services_controller/local_services.dart';

class NotificationController {
  /// Controller that handles subscription to buildings
  /// the controller first updates the new buildings locally
  /// in [SharedPreferences] by calling [addNotifierBuildings]
  /// if this goes well, sends this buldings to the Firebase Cloud Messaging server
  /// if any of the buildings failed to get to the server then the controller
  /// save those into failedToSubscribe list, which then use to remove the respective
  /// buildings names from the [SharedPreferences] list (where they were saved before).
  /// This way the app is sync with the data in the server
  static Future<List<String>> subscribeToBuildings(
      List<String> buildings) async {
    print('subscribing');
    List<String> failedToSubscribe = [];

    /// Store locally using [SharedPreferences]
    final buildingsToLocalStore = await addNotifierBuildings(buildings);

    /// If storing locally was successful, subscribe to FCM topics (building names)
    if (buildingsToLocalStore == 'ok') {
      await Future.forEach(buildings, (String element) async {
        final bool response = await FcmService.subscribeToTopic(element);

        /// If any subscription failed to get to the server, save them into
        /// a list to remove them from [SharedPreferences]
        if (!response) failedToSubscribe.add(element);
      });
    }
    if (failedToSubscribe.isNotEmpty) {
      await Future.forEach(failedToSubscribe, removeNotifierBuilding);
    }
    return failedToSubscribe;
  }

  /// Unsubscribe from building
  static Future<bool> unsubscribeFromBuilding(String building) async {
    /// THIS IS FOR JAN VIDEO - Change it back

    /// First try to unsubscribe from the topic (building) in the FCM server
    final bool response = await FcmService.subscribeToTopic(building);

    /// if unsubscribe operation succeeds, remove building name from [SharedPreferences]
    if (response) {
      await removeNotifierBuilding(building);
      return true;
    } else {
      return false;
    }
  }
}
