import 'dart:collection';

import 'event_repository.dart';
import '../map/dropdown_rate_filter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/buildingCenters.dart';
import '../data/buildingName.dart';
import '../map/heatMap.dart';
import '../models/affected_building_model.dart';

final affectedBuildingsProvider =
    StateNotifierProvider.autoDispose<BuildingNotifier>((ref) {
  print('affected building provider');

  /// A list of new events
  final eventRepository = ref.watch(eventsControllerProvider).state;

//  print(
//      '----------------list of events received in affectedBuildingsProvider----------------');
//  eventRepository.forEach((element) {
//    print(element.buildingName);
//  });

  final filterName = ref.watch(filterNameProvider).state;

  BuildingNotifier buildingNotifier = BuildingNotifier();

  /// Filter by name
  if (filterName != null && filterName != '') {
    /// ----------------Process new [BuildingEvent]s---------------------
    for (int i = 0; i < eventRepository.length; i++) {
      if (eventRepository[i]
          .buildingName
          .toLowerCase()
          .contains(filterName.toLowerCase())) {
        String tempName = eventRepository[i].buildingName;

        /// Check if the new [BuildingEvent] is in a building already affected
        /// If building list already contains building, then add the [BuildingEvent]
        int index = buildingNotifier.state.affectedBuildings
            .indexWhere((element) => element.name == tempName);
        if (index != null && index != -1) {
//          print('building exists, adding building event...');
          buildingNotifier.state.affectedBuildings[index]
              .addBuildingTimeLineEvent(eventRepository[i]);
        }

        /// If the new [BuildingEvent] is in a new [AffectedBuilding] add the building to the list
        /// and add the [BuildingEvent] to its timeline
        else {
          /// Check if building name is in the local DB first
          final int index = namesBuild.indexWhere(
              (String element) => element == eventRepository[i].buildingName);

          /// if the building name exists, add the building to the list of affected buildings
          /// and add the event to the new affected building timeline
          if (index != null && index != -1) {
            buildingNotifier.state.addBuilding(
              AffectedBuilding(
                centroid:
                    Offset(centerBuild[index].first, centerBuild[index].last),
                name: namesBuild[index],
              )..addBuildingTimeLineEvent(eventRepository[i]),
            );
          }
        }
      }
    }
  }

  ///-----------Same operation than above but without filtering------------
  else {
    for (int i = 0; i < eventRepository.length; i++) {
      String tempName = eventRepository[i].buildingName;
      int index = buildingNotifier.state.affectedBuildings
          .indexWhere((element) => element.name == tempName);
      if (index != null && index != -1) {
        buildingNotifier.state.affectedBuildings[index]
            .addBuildingTimeLineEvent(eventRepository[i]);
      } else {
        final int index = namesBuild.indexWhere(
            (String element) => element == eventRepository[i].buildingName);
        if (index != null && index != -1) {
          buildingNotifier.state.addBuilding(
            AffectedBuilding(
              centroid:
                  Offset(centerBuild[index].first, centerBuild[index].last),
              name: namesBuild[index],
            )..addBuildingTimeLineEvent(eventRepository[i]),
          );
        }
      }
    }
  }

  /// Filter by Rate
  final filterRate = ref.watch(filterRateProvider).state;

  if (filterRate != null && filterRate != '') {
    int filterActiveCases;
    switch (filterRate) {
      case '+2':
        filterActiveCases = 2;
        break;
      case '+5':
        filterActiveCases = 5;
        break;
      case '+10':
        filterActiveCases = 10;
        break;
      default:
        filterActiveCases = 0;
    }

    final filteredRateBuildings = BuildingNotifier();
    for (int i = 0; i < buildingNotifier.state.affectedBuildings.length; i++) {
      if (buildingNotifier.state.affectedBuildings[i].activeCases >=
          filterActiveCases) {
        filteredRateBuildings.state
            .addBuilding(buildingNotifier.state.affectedBuildings[i]);
      }
    }
//    print(
//        '----------------list of events provided in affectedBuildingsProvider----------------');
//    filteredRateBuildings.state.affectedBuildings.forEach((element) {
//      print(element.name);
//    });
    return filteredRateBuildings;
  } else {
//    print(
//        '----------------list of events provided in affectedBuildingsProvider----------------');
//    buildingNotifier.state.affectedBuildings.forEach((element) {
//      print(element.name);
//    });
    return buildingNotifier;
  }
});

class BuildingNotifier extends StateNotifier<BuildingController> {
  // ignore: always_specify_types
  BuildingNotifier() : super(BuildingController());
}

class BuildingController {
  BuildingController();

  List<AffectedBuilding> _affectedBuildingList = [];
  UnmodifiableListView<AffectedBuilding> get affectedBuildings =>
      UnmodifiableListView(_affectedBuildingList);

  void addBuilding(AffectedBuilding newItem) {
    _affectedBuildingList.add(newItem);
  }

  // ignore: use_setters_to_change_properties
  void setBuildings(List<AffectedBuilding> newList) {
    _affectedBuildingList = newList;
  }
}
