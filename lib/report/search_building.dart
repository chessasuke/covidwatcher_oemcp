import 'dart:ui';

import 'package:covid_watcher/data/buildingName.dart';
import 'package:covid_watcher/map/structures_provider.dart';
import 'package:covid_watcher/navigator/page_manager.dart';
import 'package:covid_watcher/report/building_finder.dart';
import 'package:covid_watcher/report/building_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:async';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

final buildingsResultsProvider = StateProvider<List<String>>((ref) => []);

class SearchBuildings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(builder: (context, watch, child) {
        final List<String> results = watch(buildingsResultsProvider).state;
        return SizedBox.expand(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    IconButton(
                        icon: const Icon(FontAwesomeIcons.arrowLeft),
                        onPressed: () => PageManager.of(context).addReport()),
                    const SizedBox(width: 20),
                    const Text('Search Building',
                        style: TextStyle(fontSize: 24)),
                    const SizedBox(width: 20),
                    const Icon(FontAwesomeIcons.solidBuilding)
                  ],
                ),
                TextField(
                  style: const TextStyle(fontSize: 20),
                  onChanged: (String value) {
                    context.read(buildingsResultsProvider).state = namesBuild
                        .where((String element) =>
                            element.toLowerCase().contains(value.toLowerCase()))
                        .toList();
                  },
                ),
                Flexible(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: results.length,
                      itemBuilder: (context, itemCount) {
                        return BuildingTile(name: results[itemCount]);
                      }),
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}

class Debouncer {
  final Duration delay;
  Timer _timer;
  Debouncer({this.delay = const Duration(milliseconds: 300)});

  void call(Function() action) {
    _timer?.cancel();
    _timer = Timer(delay, action);
  }
}
