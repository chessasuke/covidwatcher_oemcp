import 'package:covid_watcher/notifications/building_notify_tile.dart';
import 'package:covid_watcher/notifications/building_search_tile.dart';
import 'package:covid_watcher/notifications/search_notifier_building.dart';
import 'package:covid_watcher/service/firebase_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

/// A widget that when expanded, shows the buildings for which the user is subscribed
/// Shows a list view of all notifier buildings, and user can delete any of the buldings quickly

final isNotificationOpen = StateProvider<bool>((ref) => false);

class ManageNotficationBtn extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final screenSize = MediaQuery.of(context).size;
    final isOpen = watch(isNotificationOpen).state;
//    final notifierBuildings = watch(notifierBuildingProvider).state;

    final notifierBuilding = watch(notificationsProvider);

    return notifierBuilding.when(
        data: (data) => isOpen
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
                        top: BorderSide(color: Theme.of(context).dividerColor),
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
                        constraints:
                            BoxConstraints(maxHeight: screenSize.height * 0.6),
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: data.buildingsSubscribed.length,
                            itemBuilder: (context, itemCount) {
                              return BuildingNotifierTile(
                                  name: data.buildingsSubscribed[itemCount]);
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
                        top: BorderSide(color: Theme.of(context).dividerColor),
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
              ),
        loading: () => Container(
            width: 100, height: 100, child: const CircularProgressIndicator()),
        error: (error, _) =>
            Text('Ups! There was an error while fething your notifications'));
  }
}
