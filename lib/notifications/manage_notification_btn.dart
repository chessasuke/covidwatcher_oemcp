import 'dart:ui';

import 'package:covid_watcher/map/heatMap.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../models/user_state.dart';
import '../providers/loading_provider.dart';
import '../service/local_service.dart';
import 'building_notification_tile.dart';
import 'building_search_tile.dart';
import 'search_notifier_building.dart';

/// To check if it's expanded or collapsed
final isNotificationOpen = StateProvider<bool>((ref) => false);

/// Notiifcation button widget
/// A widget that when expanded, shows the buildings for which the user is subscribed
/// Shows a list view of all notifier buildings, and user can delete any of the buildings quickly

class ManageNotficationBtn extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final screenSize = MediaQuery.of(context).size;
    final isOpen = watch(isNotificationOpen).state;
    final notifierBuildings = watch(bookmarkedBuidlingsProvider);

    return notifierBuildings.when(
        data: (List<String> buildingsSubscribed) {
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
                              top: BorderSide(
                                  color: Theme.of(context).dividerColor),
                              bottom: BorderSide(
                                  color: Theme.of(context).dividerColor),
                            )),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextButton(
                            onPressed: () {
                              final currentState =
                                  context.read(isNotificationOpen).state;
                              context.read(isNotificationOpen).state =
                                  !currentState;
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: const [
                                Icon(FontAwesomeIcons.solidBell),
                                Text(
                                  'Manage Notifications',
                                  style: TextStyle(fontSize: 18),
                                ),
                                Icon(FontAwesomeIcons.angleUp),
                              ],
                            ),
                          ),
                        ),
                      ),

                      /// Btn to go to the building search dialog
                      /// where user can add buildings
                      Container(
                        decoration: BoxDecoration(
                            border: Border(
                          top:
                              BorderSide(color: Theme.of(context).dividerColor),
                          bottom:
                              BorderSide(color: Theme.of(context).dividerColor),
                        )),
                        child: GestureDetector(
                          onTap: () => showDialog(
                              context: context,
                              builder: (context) => SearchNotifierBuildings()),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: const [
                                Text('Add Buildings'),
                                Icon(FontAwesomeIcons.plusCircle)
                              ],
                            ),
                          ),
                        ),
                      ),

                      /// The list of buildings for which the user is subscribed
                      Container(
                          constraints: BoxConstraints(
                              maxHeight: screenSize.height * 0.6),
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: buildingsSubscribed.length,
                              itemBuilder: (context, itemCount) {
                                print(buildingsSubscribed.length);
                                print(
                                    'displaying buildings retrieved from shared preferences');

                                /// OEMCP version
                                return BuildingNotificationTile(
                                  name: buildingsSubscribed[itemCount],
                                  callback: () async {
                                    UserState userState =
                                        context.read(userProvider.state);

                                    /// Check if user session is still active
                                    if (userState is UserLoaded) {
                                      /// set isLoading
                                      context.read(loadingProvider).state =
                                          true;

                                      await removeNotifierBuilding(
                                          buildingsSubscribed[itemCount]);

                                      await context
                                          .refresh(bookmarkedBuidlingsProvider);

                                      context.read(loadingProvider).state =
                                          false;

                                      /// Clean the list of selected notifier buildings
                                      /// IMPORTANT - This must be done before setting state of [notifierBuildingsSelected]
                                      /// because then this [BuildingNotifierTile] widget along with its context will be deleted
                                      /// and an error of the type
                                      /// "Error: Looking up a deactivated widget's ancestor is unsafe"
                                      /// will be throw
                                      final stateSelected = context
                                          .read(notifierBuildingsSelected);
                                      stateSelected.state = [];

                                      /// REMEMBER instead of modifying the list, u must modify the state
                                      /// The below code is bad:
                                      /// context.read(notifierBuildingProvider).state.remove(name)
                                      /// it wont trigger the UI
                                      List<String> temp = context
                                          .read(notifierBuildingsSelected)
                                          .state;
                                      // ignore: cascade_invocations
                                      temp.remove(
                                          buildingsSubscribed[itemCount]);
                                      final state = context
                                          .read(notifierBuildingsSelected);
                                      state.state = temp;

                                      /// Show snackbar
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              backgroundColor: Colors
                                                  .transparent
                                                  .withOpacity(0.6),
                                              content: Text(
                                                'Unsubscribed from building ${buildingsSubscribed[itemCount]}',
                                                style: const TextStyle(
                                                    color: Colors.white),
                                              )));
                                    }
                                  },
                                );
                              }))
                    ],
                  ),
                )
              : GestureDetector(
                  onTap: () {
                    final currentState = context.read(isNotificationOpen).state;
                    context.read(isNotificationOpen).state = !currentState;
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).buttonColor.withOpacity(
                            0.7), //                color: Color(0xEB3A60),
                        border: Border(
                          top:
                              BorderSide(color: Theme.of(context).dividerColor),
                          bottom:
                              BorderSide(color: Theme.of(context).dividerColor),
                        )),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: const [
                          Icon(FontAwesomeIcons.solidBell),
                          Text(
                            'Manage Notifications',
                            style: TextStyle(fontSize: 18),
                          ),
                          Icon(FontAwesomeIcons.angleDown)
                        ],
                      ),
                    ),
                  ),
                );
        },
        loading: () => const CircularProgressIndicator(),
        error: (Object error, _) => Text('Error: $error'));
  }
}
