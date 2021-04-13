import 'package:covid_watcher/navigator/page_manager.dart';
import 'package:covid_watcher/report/search_building.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

final buildingsAffectedSelected = StateProvider<List<String>>((ref) => []);

class CustomBuildingFinder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, child) {
      final List<String> buildingsSelected =
          watch(buildingsAffectedSelected).state;

      print(buildingsSelected.length);

      return Container(
        child: buildingsSelected.isEmpty
            ? GestureDetector(
                onTap: () => showDialog(
                    context: context, builder: (context) => SearchBuildings()),
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
            : Flexible(
                child: GestureDetector(
                  onTap: () => showDialog(
                      context: context,
                      builder: (context) => SearchBuildings()),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        buildingsSelected.join(", "),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(bottom: 4.0),
                        child: Icon(FontAwesomeIcons.solidEdit, size: 20),
                      )
                    ],
                  ),
                ),
              ),
      );
    });
  }
}
