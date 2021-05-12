import 'package:covid_watcher/controllers/navigator_controller.dart';
import 'package:covid_watcher/models/fcm_notification_model.dart';
import 'package:covid_watcher/notifications/fcm_notifications/fcm_notification_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../providers/general_providers.dart';
import '../../providers/notifications_providers.dart';
import '../../controllers/user_state.dart';

/// Notiifcation button widget
/// A widget that when expanded, shows the user notifications

class FcmNotificationsBtn extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final screenSize = MediaQuery.of(context).size;
    final isOpen = watch(isNotificationsOpen).state;
    final notificationsList = watch(fcmNotificationListProvider).state;

    return isOpen
        ? Container(
            color: Theme.of(context).cardColor.withOpacity(0.2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).buttonColor.withOpacity(
                          0.7), //                color: Color(0xEB3A60),
                      border: Border(
                        top: BorderSide(color: Theme.of(context).dividerColor),
                        bottom:
                            BorderSide(color: Theme.of(context).dividerColor),
                      )),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton(
                      onPressed: () {
                        final currentState =
                            context.read(isNotificationsOpen).state;
                        context.read(isNotificationsOpen).state = !currentState;
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Flexible(child: Icon(FontAwesomeIcons.solidBell)),
                          Text(
                            'Notifications',
                            style: TextStyle(fontSize: 18),
                            overflow: TextOverflow.clip,
                          ),
                          Flexible(child: Icon(FontAwesomeIcons.angleUp)),
                        ],
                      ),
                    ),
                  ),
                ),

                /// The list of notifications received
                Container(
                    constraints:
                        BoxConstraints(maxHeight: screenSize.height * 0.2),
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: notificationsList.length,
                        itemBuilder: (context, itemCount) {
                          if (notificationsList.isEmpty) {
                            return const Text('No Notifications');
                          }

                          /// OEMCP version
                          return FcmNotificationTile(
                            notification: notificationsList[itemCount],
                            deleteCallback: () async {
                              UserState userState =
                                  context.read(userController.state);

                              /// Check if user session is still active
                              if (userState is UserLoaded) {
                                /// set isLoading
                                context.read(loadingProvider).state = true;

                                print(
                                    'notifications length before: ${context.read(fcmNotificationListProvider).state}');

                                /// REMEMBER instead of modifying the list, u must modify the state
                                /// The below code is bad:
                                /// context.read(notifierBuildingProvider).state.remove(name)
                                /// it wont trigger the UI
                                List<FcmNotificationModel> temp = context
                                    .read(fcmNotificationListProvider)
                                    .state;
                                // ignore: cascade_invocations
                                temp.remove(notificationsList[itemCount]);
                                final state =
                                    context.read(fcmNotificationListProvider);
                                state.state = temp;

                                print(
                                    'notifications length after: ${context.read(fcmNotificationListProvider).state}');

                                context.read(loadingProvider).state = false;

                                /// Show snackbar
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        backgroundColor:
                                            Colors.transparent.withOpacity(0.6),
                                        content: const Text(
                                          'Notification Deleted',
                                          style: TextStyle(color: Colors.white),
                                        )));
                              }
                            },
                            viewCallback: (String id) {
                              NavigatorController.of(context)
                                  .addNotificationScreen(id);
                            },
                          );
                        }))
              ],
            ),
          )
        : GestureDetector(
            onTap: () {
              final currentState = context.read(isNotificationsOpen).state;
              context.read(isNotificationsOpen).state = !currentState;
            },
            child: Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).buttonColor.withOpacity(
                      0.7), //                color: Color(0xEB3A60),
                  border: Border(
                    top: BorderSide(color: Theme.of(context).dividerColor),
                    bottom: BorderSide(color: Theme.of(context).dividerColor),
                  )),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Flexible(child: Icon(FontAwesomeIcons.solidBell)),
                    Text(
                      'Notifications',
                      style: TextStyle(fontSize: 18),
                      overflow: TextOverflow.clip,
                    ),
                    Flexible(child: Icon(FontAwesomeIcons.angleDown))
                  ],
                ),
              ),
            ),
          );
  }
}
