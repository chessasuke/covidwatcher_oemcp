import 'dart:ui';

import 'package:covid_watcher/controllers/affected_buildings.dart';
import 'package:covid_watcher/map/info_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../models/affected_building_model.dart';
import 'custom_searchbar.dart';
import 'dropdown_date_filter.dart';
import 'dropdown_rate_filter.dart';
import 'marker.dart';
import 'structure_model.dart';
import 'structures_provider.dart';
import 'updated_custom_map.dart';

final showBuildingMarkerProvider = StateProvider<bool>((ref) => false);
final showStructureMarkerProvider = StateProvider<bool>((ref) => false);
final showSearchBarProvider = StateProvider<bool>((ref) => false);
final filterNameProvider = StateProvider<String>((ref) => '');

class Heatmap extends ConsumerWidget {
  static const double scaleLimit = 1.6487212707001282;

  List<Widget> buildList(
    Size screenSize,
    bool showBuildingsMarker,
    bool showStructuresMarker,
    bool showSearchBar,
    List<Structure> buildings,
    List<Structure> structures4d,
    List<Street> streets,
    BuildingController buildingController,
  ) {
    List<Widget> list = [
      Container(
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

    for (int i = 0; i < buildingController.affectedBuildings.length; i++) {
      AffectedBuilding temp = AffectedBuilding(
        centroid: Offset(
            (buildingController.affectedBuildings[i].centroid.dx) +
                (screenSize.width / 2),
            (buildingController.affectedBuildings[i].centroid.dy) +
                ((screenSize.height - bottomBarHeight) / 1.2)),
        name: buildingController.affectedBuildings[i].name,
      )..addBuildingTimeLine(
          buildingController.affectedBuildings[i].buildingTimeline);
      list.add(
        CustomMarker(affectedBuilding: temp),
      );
    }

    return list;
  }

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final showBuildingMarker = watch(showBuildingMarkerProvider).state;
    final showStructureMarker = watch(showStructureMarkerProvider).state;
    final showSearchBar = watch(showSearchBarProvider).state;

//    var filterName = watch(filterNameProvider).state;

    final buildings = watch(buildingProvider);
    final affectedBuildings = watch(affectedBuildingsProvider).state;

    final structures4d = watch(structure4dProvider);
    final streets = watch(streetsProvider);

    final Size screenSize = MediaQuery.of(context).size;

    /// -----------------------------------------------------
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.black,
        body: Stack(children: [
          InteractiveViewer(
            maxScale: 3.5,
            minScale: 1,
            child: Stack(
                children: buildList(
              screenSize,
              showBuildingMarker,
              showStructureMarker,
              showSearchBar,
              buildings,
              structures4d,
              streets,
              affectedBuildings,
            )),
          ),
          if (showSearchBar)
            CustomSearchBar(
              callback: (String value) {
                context.read(filterNameProvider).state = value;
//                print('filter: $filterName');
              },
            ),
          Positioned(
              top: screenSize.height / 2 - 58,
              left: 20,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  border: Border.all(color: Colors.white),
                  color: Colors.black.withOpacity(0.8),
                ),
                child: Column(
                  children: [
                    IconButton(
                        icon: Icon(
                          FontAwesomeIcons.search,
                          color: showSearchBar
                              ? Theme.of(context).accentColor
                              : Colors.white,
                        ),
                        onPressed: () {
                          context.read(showSearchBarProvider).state =
                              !context.read(showSearchBarProvider).state;
                        }),
                    IconButton(
                        icon: const Icon(
                          FontAwesomeIcons.filter,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return Container(
                                  constraints: const BoxConstraints(
                                      maxWidth: 300, maxHeight: 300),
                                  child: SimpleDialog(
                                      backgroundColor: Theme.of(context)
                                          .dialogBackgroundColor,
                                      elevation: 30,
                                      title: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: const [
                                          Flexible(
                                              child: Icon(
                                                  FontAwesomeIcons.filter)),
                                          SizedBox(width: 20),
                                          Flexible(child: Text('Filters')),
                                        ],
                                      ),
                                      children: [
                                        SizedBox(height: 10),
                                        DropdownDateFilter(),
                                        DropdownRateFilter(),
                                      ]),
                                );
                              });
                        }),
                    IconButton(
                        icon: Icon(
                          FontAwesomeIcons.solidBuilding,
                          color: showBuildingMarker
                              ? Theme.of(context).accentColor
                              : Colors.white,
                        ),
                        onPressed: () {
                          context.read(showBuildingMarkerProvider).state =
                              !context.read(showBuildingMarkerProvider).state;
                        }),
                    IconButton(
                        icon: Icon(FontAwesomeIcons.mapMarkerAlt,
                            color: showStructureMarker
                                ? Theme.of(context).accentColor
                                : Colors.white),
                        onPressed: () {
                          context.read(showStructureMarkerProvider).state =
                              !context.read(showStructureMarkerProvider).state;
                        }),
                    IconButton(
                        icon: const Icon(FontAwesomeIcons.replyAll,
                            color: Colors.white),
                        onPressed: () {
                          context.read(showStructureMarkerProvider).state =
                              false;
                          context.read(showSearchBarProvider).state = false;
                          context.read(showBuildingMarkerProvider).state =
                              false;
                          context.read(filterNameProvider).state = '';
                          context.read(filterDateProvider).state = 'Last Month';
                          context.read(filterRateProvider).state = '+0';
                        }),
                    IconButton(
                        icon: const Icon(FontAwesomeIcons.infoCircle,
                            color: Colors.white),
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return InfoDialog();
                              });
                        }),
                  ],
                ),
              ))
        ]));
  }
}
