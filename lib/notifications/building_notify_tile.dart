import 'package:covid_watcher/models/user_state.dart';
import 'package:covid_watcher/notifications/logic_notification.dart';
import 'package:covid_watcher/providers/loading_provider.dart';
import 'package:covid_watcher/service/firebase_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'building_search_tile.dart';
import 'package:covid_watcher/screens_mobile/screen_settings.dart';

/// Tiles that appear in the manage notification section with
/// the Buildings for which we are subscribed to receive notifications

class BuildingNotifierTile extends StatelessWidget {
  const BuildingNotifierTile({this.name});
  final String name;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(name),
      trailing: IconButton(
          icon: const Icon(FontAwesomeIcons.solidTrashAlt),
          onPressed: () async {
            UserState userState = context.read(userProvider.state);

            /// Check if user session is still active
            if (userState is UserLoaded) {
              /// set isLoading
              context.read(loadingProvider).state = true;
              final String statusCode =
                  await removeNotifierBuilding(name, userState.user.getUid);
              context.read(loadingProvider).state = false;
              if (statusCode == 'ok') {
                /// Clean the list of selected notifier buildings
                /// IMPORTANT - This must be done before setting state of [notifierBuildingsSelected]
                /// because then this [BuildingNotifierTile] widget along with its context will be deleted
                /// and an error of the type
                /// "Error: Looking up a deactivated widget's ancestor is unsafe"
                /// will be throw
                final stateSelected = context.read(notifierBuildingsSelected);
                stateSelected.state = [];

                /// REMEMBER instead of modifying the list, u must modify the state
                /// The below code is bad:
                /// context.read(notifierBuildingProvider).state.remove(name)
                /// it wont trigger the UI
                List<String> temp =
                    context.read(notifierBuildingsSelected).state;
                temp.remove(name);
                final state = context.read(notifierBuildingsSelected);
                state.state = temp;
                await context.refresh(notificationsProvider);

                /// Show snackbar
                ScaffoldMessenger.of(settingsScaffold.currentContext)
                    .showSnackBar(SnackBar(
                        backgroundColor: Colors.transparent.withOpacity(0.6),
                        content: Text(
                          'Unsubscribed from building $name',
                          style: const TextStyle(color: Colors.white),
                        )));
              } else {
                await showDialog(
                    context: context,
                    builder: (context) => const AlertDialog(
                          title: Text('Error'),
                          actions: [
                            Text('Error while updating your notifications')
                          ],
                        ));
              }
            }
          }),
    );
  }
}
