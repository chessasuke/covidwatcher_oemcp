import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../data/buildingName.dart';
import '../models/user_state.dart';
import '../notifications/building_search_tile.dart';
import '../providers/loading_provider.dart';
import '../service/firebase_services.dart';
import 'logic_notification.dart';

final buildingsResults = StateProvider<List<String>>((ref) => []);

/// TODO - FutureProvider to fetch notifier buildings

/// TODO CHECK IF IS POSSIBLE TO MERGE THE TWO SEARCHING DIALOGS

class SearchNotifierBuildings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Consumer(builder: (context, watch, child) {
          final screenSize = MediaQuery.of(context).size;
          final List<String> results = watch(buildingsResults).state;
          final isLoading = watch(loadingProvider).state;

          return SizedBox.expand(
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ///
                      Row(
                        children: [
                          IconButton(
                              icon: const Icon(FontAwesomeIcons.check),
                              onPressed: () async {
                                String statusCode = 'ok';
                                String uid;
                                final currentUser =
                                    context.read(userProvider.state);
                                if (currentUser is UserLoaded) {
                                  context.read(loadingProvider).state = true;
                                  uid = currentUser.user.getUid;
                                  for (String building in context
                                      .read(notifierBuildingsSelected)
                                      .state) {
                                    statusCode = await updateNotifierBuilding(
                                        building, uid);
                                    if (statusCode != 'ok') break;
                                  }
                                  context.read(loadingProvider).state = false;
                                }
                                if (statusCode != 'ok') {
                                  await showDialog(
                                      context: context,
                                      builder: (context) => const AlertDialog(
                                            title: Text('Error'),
                                            actions: [Text('Operation Failed')],
                                          ));
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          backgroundColor: Colors.transparent
                                              .withOpacity(0.7),
                                          elevation: 50,
                                          content: const Text(
                                            'Notifications Updated',
                                            style:
                                                TextStyle(color: Colors.white),
                                          )));
                                  await context.refresh(notificationsProvider);
                                }

                                Navigator.pop(context);
                              }),
                          const SizedBox(width: 20),
                          const Text('Search Building',
                              style: TextStyle(fontSize: 24)),
                          const SizedBox(width: 20),
                          const Icon(FontAwesomeIcons.solidBuilding)
                        ],
                      ),

                      /// Provides the buildings results according to user input
                      TextField(
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
                      Flexible(
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: results.length,
                            itemBuilder: (context, itemCount) {
                              return BuildingSearchTile(
                                  name: results[itemCount]);
                            }),
                      )
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
