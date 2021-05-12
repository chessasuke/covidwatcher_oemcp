import 'package:covid_watcher/heatmap/logic/map_custom_painter.dart';
import '../heatmap/widgets/custom_marker.dart';
import '../models/structure_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../models/affected_building_model.dart';
import 'affected_buildings_controller.dart';

/// Controls the render of the heatmap, combining the structure providers from the [Local DB]
/// and the affected buildings from the [Service Controller]

class HeatmapController {
  static List<Widget> buildMap(
    Size screenSize,
    bool showBuildingsMarker,
    bool showStructuresMarker,
    bool showSearchBar,
    bool showBookmarked,
    List<StructureModel> buildings,
    List<StructureModel> structures4d,
    List<StreetModel> streets,
    BuildingController buildingController,
    List<String> favsBuilding,
  ) {
    List<Widget> list = [
      SizedBox(
        width: screenSize.width,
        height: screenSize.height,
        child: RepaintBoundary(
          child: CustomPaint(
            isComplex: true,
            painter: UpdatedCustomMap(),
            child: const SizedBox(),
          ),
        ),
      )
    ];

    /// Height of the bottom bar
    double bottomBarHeight = 0;
    if (screenSize.width < 500) {
      bottomBarHeight = 58;
    }

    /// Show buildings markers?
    if (showBuildingsMarker) {
      for (int i = 0; i < buildings.length; i++) {
        /// Dont show marker if it's an [AffectedBuilding]
        if (buildingController.affectedBuildings
                .indexWhere((element) => element.name == buildings[i].name) !=
            -1) {
          continue;
        }

        /// correct the offset of the coordinates
        /// width - 5 and heigth - 10 because of the size of the icons
        /// -58 if it's a mobile device screen (>500 pixels)
        /// because of the bottom bar
        final offsetCorrected = [
          buildings[i].centroid.first + screenSize.width / 2 - 5,
          buildings[i].centroid.last +
              (screenSize.height - bottomBarHeight) / 1.2 -
              10
        ];
        list.add(Positioned(
            left: offsetCorrected.first,
            top: offsetCorrected.last,
            child: Tooltip(
              message: buildings[i].name,
              child: Icon(
                FontAwesomeIcons.solidBuilding,
                color: Colors.lightBlue.withOpacity(0.7),
                size: 10,
              ),
            )));
      }
    }

    /// Show structures markers?
    if (showStructuresMarker) {
      for (int i = 0; i < structures4d.length; i++) {
        var offsetCorrected = [
          structures4d[i].centroid.first + screenSize.width / 2 - 5,
          structures4d[i].centroid.last +
              (screenSize.height - bottomBarHeight) / 1.2 -
              10
        ];
        list.add(Positioned(
            left: offsetCorrected.first,
            top: offsetCorrected.last,
            child: Tooltip(
              message: structures4d[i].name,
              child: Icon(
                FontAwesomeIcons.mapMarkerAlt,
                color: Colors.lightBlue.withOpacity(0.7),
                size: 10,
              ),
            )));
      }
    }

    /// Show street markers?
    if (showStructuresMarker) {
      for (int i = 0; i < streets.length; i++) {
        var offsetCorrected = [
          streets[i].coordinates.first + (screenSize.width / 2),
          streets[i].coordinates.last +
              ((screenSize.height - bottomBarHeight) / 1.2)
        ];
        list.add(
          Positioned(
              left: offsetCorrected.first as double,
              top: offsetCorrected.last as double,
              child: Tooltip(
                message: streets[i].name,
                child: Icon(
                  FontAwesomeIcons.mapMarkerAlt,
                  color: Colors.lightBlue.withOpacity(0.7),
                  size: 10,
                ),
              )),
        );
      }
    }

    /// Affected buildings
    for (int i = 0; i < buildingController.affectedBuildings.length; i++) {
      if (showBookmarked == true) {
        if (favsBuilding.map((e) => e.toLowerCase()).toList().contains(
            buildingController.affectedBuildings[i].name.toLowerCase())) {
          AffectedBuilding temp = AffectedBuilding(
            centroid: Offset(
                (buildingController.affectedBuildings[i].centroid.dx) +
                    (screenSize.width / 2) -
                    5,
                (buildingController.affectedBuildings[i].centroid.dy) +
                    ((screenSize.height - bottomBarHeight) / 1.2) -
                    10),
            name: buildingController.affectedBuildings[i].name,
          )..addBuildingTimeLine(
              buildingController.affectedBuildings[i].buildingTimeline);
          list.add(
            CustomMarker(affectedBuilding: temp),
          );
        } else {
          continue;
        }
      }

      AffectedBuilding temp = AffectedBuilding(
        centroid: Offset(
            (buildingController.affectedBuildings[i].centroid.dx) +
                (screenSize.width / 2) -
                5,
            (buildingController.affectedBuildings[i].centroid.dy) +
                ((screenSize.height - bottomBarHeight) / 1.2) -
                10),
        name: buildingController.affectedBuildings[i].name,
      )..addBuildingTimeLine(
          buildingController.affectedBuildings[i].buildingTimeline);
      list.add(
        CustomMarker(affectedBuilding: temp),
      );
    }

    return list;
  }
}
