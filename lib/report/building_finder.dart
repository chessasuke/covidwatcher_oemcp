import 'package:covid_watcher/navigator/page_manager.dart';
import 'package:covid_watcher/report/search_building.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

final buildingsAffectedSelected = StateProvider<List<String>>((ref) => []);

class CustomBuildingFinder extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return Consumer(builder: (context, watch, child) {
      final List<String> buildingsSelected =
          watch(buildingsAffectedSelected).state;

      print('buildingsSelected: ${buildingsSelected.length}');

      return Container(
        child: buildingsSelected.isEmpty
            ? GestureDetector(
                onTap: () {
                  PageManager.of(context).addSearchingBuilding();
                },
                child: Row(
                  children: const [
                    Flexible(
                      child: Text('Add/Remove Buildings',
                          style: TextStyle(fontSize: 24)),
                    ),
                    SizedBox(width: 20),
                    Padding(
                      padding: EdgeInsets.only(bottom: 4.0),
                      child: Icon(FontAwesomeIcons.plusCircle, size: 20),
                    ),
                  ],
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Flexible(
                      child: Text(
                    buildingsSelected.join(", "),
                  )),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4.0),
                    child: GestureDetector(
                        onTap: () =>
                            PageManager.of(context).addSearchingBuilding(),
                        child:
                            const Icon(FontAwesomeIcons.solidEdit, size: 20)),
                  )
                ],
              ),
      );
    });
  }
}
