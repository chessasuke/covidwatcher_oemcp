import 'package:covid_watcher/controllers/notification_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../controllers/user_state.dart';
import '../../local_data/buildingName.dart';
import '../../providers/general_providers.dart';
import '../../providers/heatmap_providers.dart';
import '../../providers/notifications_providers.dart';
import 'favorite_search_tile.dart';

/// Dialog that popups to search buildings and add them to notification settings

/// TODO - FutureProvider to fetch notifier buildings

/// TODO CHECK IF IS POSSIBLE TO MERGE THE TWO SEARCHING DIALOGS

class SearchSubscribedBuildings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Consumer(builder: (context, watch, child) {
          final screenSize = MediaQuery.of(context).size;
          final List<String> results = watch(buildingsResults).state;
          final isLoading = watch(loadingProvider).state;

          return SizedBox.expand(
            /// Stack to show the isLoading process
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: IconButton(
                                icon: const Icon(FontAwesomeIcons.check),
                                onPressed: () async {
                                  if (context
                                      .read(notifierBuildingsSelected)
                                      .state
                                      .isNotEmpty) {
                                    print('save new buildings');
//                                    String statusCode = 'ok';
                                    final currentUser =
                                        context.read(userController.state);
                                    if (currentUser is UserLoaded) {
                                      /// Start the saving process
                                      context.read(loadingProvider).state =
                                          true;

                                      /// OEMCP version
                                      /// save to shared preference and to a state provider
                                      List<String> buildingFailedToSubscribe =
                                          [];
                                      buildingFailedToSubscribe =
                                          await NotificationController
                                              .subscribeToBuildings(context
                                                  .read(
                                                      notifierBuildingsSelected)
                                                  .state);
                                      if (buildingFailedToSubscribe
                                          .isNotEmpty) {
                                        buildingFailedToSubscribe
                                            .forEach((element) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  duration: const Duration(
                                                      seconds: 5),
                                                  backgroundColor: Colors
                                                      .transparent
                                                      .withOpacity(0.7),
                                                  elevation: 50,
                                                  content: Text(
                                                    'Failed to subscribe to $element',
                                                    style: const TextStyle(
                                                        color: Colors.white),
                                                  )));
                                        });
                                      } else {
                                        context
                                            .read(notifierBuildingsSelected)
                                            .state
                                            .forEach((element) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  backgroundColor: Colors
                                                      .transparent
                                                      .withOpacity(0.7),
                                                  elevation: 50,
                                                  content: Text(
                                                    'Subscribed to $element',
                                                    style: const TextStyle(
                                                        color: Colors.white),
                                                  )));
                                        });
                                      }
                                      await context
                                          .refresh(bookmarkedBuidlingsProvider);

                                      context.read(loadingProvider).state =
                                          false;
                                    }
                                  } else {
                                    print('no buildings selected');
                                  }
                                  context
                                      .read(notifierBuildingsSelected)
                                      .state = [];
                                  Navigator.pop(context);
                                }),
                          ),
                          const SizedBox(width: 20),
                          const Flexible(
                            child: Text('Search Building',
                                style: TextStyle(fontSize: 24)),
                          ),
                          const SizedBox(width: 20),
                          Align(
                              alignment: Alignment.centerRight,
                              child: IconButton(
                                  onPressed: () {
                                    context
                                        .read(notifierBuildingsSelected)
                                        .state = [];
                                    Navigator.pop(context);
                                  },
                                  icon: const Icon(
                                      FontAwesomeIcons.solidTimesCircle)))
                        ],
                      ),

                      /// Provides the buildings results according to user input
                      Flexible(
                        child: TextField(
                          decoration: const InputDecoration(
                              hintText: 'Search and add buildings'),
                          style: const TextStyle(fontSize: 20),
                          onChanged: (String value) {
                            context.read(buildingsResults).state = namesBuild
                                .where((String element) => element
                                    .toLowerCase()
                                    .contains(value.toLowerCase()))
                                .toList();
                          },
                        ),
                      ),
                      Flexible(
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: results.length,
                            itemBuilder: (context, itemCount) {
                              return SearchBuildingTile(
                                  name: results[itemCount]);
                            }),
                      ),
                    ],
                  ),
                ),
                if (isLoading)
                  Container(
                    width: screenSize.width,
                    height: screenSize.height,
                    color: Colors.transparent.withOpacity(0.7),
                    child: const Center(child: CircularProgressIndicator()),
                  ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
