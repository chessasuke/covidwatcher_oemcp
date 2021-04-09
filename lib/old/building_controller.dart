//import 'dart:collection';
//
//import 'package:flutter/material.dart';
//import 'package:flutter_riverpod/flutter_riverpod.dart';
//
//import '../data/utd_campus_map_data_v2.dart';
//import '../heatmap/search_bar.dart';
//import '../models/building_event_model.dart';
//import '../models/affected_building_model.dart';
//import 'covid_case_controller.dart';
//import 'sanitized_case_controller.dart';
//
//final buildingProvider =
//    ChangeNotifierProvider.autoDispose<BuildingController>((ref) {
//  /// The current list of buildings
//  final buildingController = ref.watch(buildingControllerProvider);
//
//  /// A list of new covid events
//  final newCovidItems = ref.watch(covidCasesProvider);
//
//  /// A list of new sanitation events
//  final newSanitizedItems = ref.watch(sanitizedCasesProvider);
//
//  /// New [BuildingEvent]s
//  List<BuildingEventModel> newCases = [];
//
//  newCovidItems.whenData((value) => value.docChanges.forEach((element) {
//        newCases.add(
//            BuildingEventModel.fromDocumentSnapshot(element.doc, type: true));
////        newCases.toSet().toList();
//      }));
//
//  newSanitizedItems.whenData((value) => value.docChanges.forEach((element) {
//        print('sanitized case: ${element.doc.data()['building']}');
//        newCases.add(
//            BuildingEventModel.fromDocumentSnapshot(element.doc, type: false));
////        newCases.toSet().toList();
//      }));
//
//  /// ----------------Process new infection events---------------------
//  for (int i = 0; i < newCases.length; i++) {
//    if (buildingController.casesIDs != null &&
//        buildingController.casesIDs.contains(newCases[i].id)) {
//      continue;
//    } else {
//      buildingController.addID(newCases[i].id);
//    }
//
//    String tempName = newCases[i].buildingName;
//
//    /// Check if the new [BuildingEvent] is in a building already affected
//    /// If building list already contains building, then add the [BuildEvent]
//    if (buildingController.buildingNames.contains(tempName)) {
//      int index = buildingController.buildings
//          .indexWhere((element) => element.name == tempName);
//      if (index != null && index != -1) {
//        buildingController.buildings[index]
//            .addBuildingTimeLineEvent(newCases[i]);
//      }
//    }
//
//    /// If the new [BuildingEvent] is in a new building add the building to the list
//    /// and add the [BuildingEvent] to its timeline
//    else {
//      /// Check if building name is in the local DB
//      final int index = dataNames
//          .indexWhere((String element) => element == newCases[i].buildingName);
//      if (index != null && index != -1) {
//        buildingController.addBuilding(Building(
//            coordinate: Offset(dataCoordinates[index][0][0].first as double,
//                dataCoordinates[index][0][0].last as double),
//            name: dataNames[index])
//          ..addBuildingTimeLineEvent(newCases[i]));
//        buildingController.addName(dataNames[index]);
//      }
//    }
//  }
//
//  ref.maintainState = true;
//
//  print(
//      'buildingController.buildings.length before returning: ${buildingController.buildings.length}');
//
//  return buildingController;
//});
//
//final buildingControllerProvider = Provider((ref) {
//  return BuildingController();
//});
//
//class BuildingController extends ChangeNotifier {
//  BuildingController();
//
//  List<String> _casesIDs = [];
//  UnmodifiableListView<String> get casesIDs => UnmodifiableListView(_casesIDs);
//
//  List<String> _buildingNames = [];
//  UnmodifiableListView<String> get buildingNames =>
//      UnmodifiableListView(_buildingNames);
//
//  List<Building> _buildingList = [];
//  UnmodifiableListView<Building> get buildings =>
//      UnmodifiableListView(_buildingList);
//
//  void addBuilding(Building newItem) {
//    _buildingList.add(newItem);
//    notifyListeners();
//  }
//
//  // ignore: use_setters_to_change_properties
//  void setBuildings(List<Building> newList) {
//    _buildingList = newList;
//  }
//
//  void addName(String newItem) {
//    _buildingNames.add(newItem);
//  }
//
//  void addID(String newID) {
//    _casesIDs.add(newID);
//  }
//}
