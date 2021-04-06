import 'package:covid_watcher/controllers/filterProvider.dart';
import 'package:covid_watcher/heatmap/search_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/building_controller.dart';
import '../data/utd_campus_map_data_v2.dart';
import '../models/building_model.dart';
import 'custom_map.dart';
import 'marker.dart';

class Heatmap extends StatefulWidget {
  @override
  _HeatmapState createState() => _HeatmapState();
}

class _HeatmapState extends State<Heatmap> {
  String filter = '';

  List<Widget> buildList(Size screenSize, List<Building> buildingList) {
    List<Widget> children = [
      Container(
        width: screenSize.width,
        height: screenSize.height,
        child: RepaintBoundary(
          child: CustomPaint(
            isComplex: true,
            willChange: false,
            painter: CustomMap2(
              coordinates: dataCoordinates,
              screenSize: screenSize,
            ),
            child: const SizedBox(),
          ),
        ),
      ),
    ];

    /// Take into account the bottom bar height in mobile devices (width < 500)
    /// in this case is 58 logical pixels
    double currentHeight;
    if (screenSize.width < 500) {
      currentHeight = screenSize.height - 58;
    } else {
      currentHeight = screenSize.height;
    }

    for (int i = 0; i < buildingList.length; i++) {
      Building temp = Building(
        coordinate: Offset(buildingList[i].coordinate.dx + screenSize.width / 2,
            -(buildingList[i].coordinate.dy) + currentHeight / 1.2),
        name: buildingList[i].name,
      );
      temp.addBuildingTimeLine(buildingList[i].buildingTimeline);
      children.add(CustomMarker(building: temp));
    }

    children.add(CustomSearchBar(
      callback: (String value) {
        setState(() {
          filter = value;
        });
      },
    ));

    return children;
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.black,
        body: InteractiveViewer(
          child: Consumer(builder:
              (BuildContext context, ScopedReader watch, Widget child) {
            final buildingList = watch(filterProvider(filter));

            if (buildingList != null) {
              return Stack(
                alignment: Alignment.center,
                children: buildList(screenSize, buildingList),
              );
            } else {
              return const CircularProgressIndicator();
            }
          }),
        ));
  }
}

/// Hardcoded data to test
//final dummyData = [
//  Building(
//      coordinate: Offset(dataCoordinates[3][0][0].first as double,
//          dataCoordinates[3][0][0].last as double),
//      name: dataNames[3])
//    ..addBuildingTimeLineEvent(BuildingEvent(
//      type: true, // infected
//      comment: 'student by the staff',
//    )),
//  Building(
//      coordinate: Offset(dataCoordinates[3][0][0].first as double,
//          dataCoordinates[3][0][0].last as double),
//      name: dataNames[3])
//    ..addBuildingTimeLineEvent(BuildingEvent(
//      type: true, // infected
//      comment: 'student by the staff',
//    )),
//  Building(
//      coordinate: Offset(dataCoordinates[33][0][0].first as double,
//          dataCoordinates[33][0][0].last as double),
//      name: dataNames[33])
//    ..addBuildingTimeLineEvent(BuildingEvent(
//      type: true, // infected
//      comment: 'student by the staff',
//    )),
//  Building(
//      coordinate: Offset(dataCoordinates[45][0][0].first as double,
//          dataCoordinates[45][0][0].last as double),
//      name: dataNames[45])
//    ..addBuildingTimeLineEvent(BuildingEvent(
//      type: true, // infected
//      comment: 'student by the staff',
//    )),
//];
