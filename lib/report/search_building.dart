import 'dart:async';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../data/buildingName.dart';
import 'building_tile.dart';

final buildingsResultsProvider = StateProvider<List<String>>((ref) => []);

class SearchBuildings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Consumer(builder: (context, watch, child) {
          List<String> results = watch(buildingsResultsProvider).state;

          return SizedBox.expand(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: IconButton(
                          icon: const Icon(FontAwesomeIcons.arrowLeft),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                      const SizedBox(width: 20),
                      const Flexible(
                        child: Text('Search Building',
                            style: TextStyle(fontSize: 24)),
                      ),
                      const SizedBox(width: 20),
                      const Icon(FontAwesomeIcons.solidBuilding)
                    ],
                  ),
                  Flexible(
                    child: TextField(
                      decoration: const InputDecoration(
                          hintText: 'Search and add/remove buildings'),
                      style: const TextStyle(fontSize: 20),
                      onChanged: (String value) {
                        context.read(buildingsResultsProvider).state =
                            namesBuild
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
                          return BuildingTile(name: results[itemCount]);
                        }),
                  )
                ],
              ),
            ),
          );
        }),
      ),
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
