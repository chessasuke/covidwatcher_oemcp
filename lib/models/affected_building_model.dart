import 'dart:collection';

import 'package:flutter/material.dart';

import 'building_event_model.dart';

class AffectedBuilding {
  AffectedBuilding({
    this.centroid,
    this.name,
  });

  /// Name of the building provided by dataCoordinate
  final String name;

  /// The first Offset provided by dataCoordinate for this building
  /// It's where the marker will appear
  final Offset centroid;

  /// The timestamp of the last [BuildingEvent]
  DateTime _timestamp;
  DateTime get timestamp => _timestamp;

  /// Not-yet-sanitized Covid Cases in the building if any
  int _activeCases;
  int get activeCases => _activeCases;

  /// 2 possible status - infected(recently involved with a covid case),
  /// sanitized(recently involved in a covid case but already sanitized by Staff)
  /// The current status is determined by the last [BuildingEvent]
  bool _status;
  bool get status => _status;

  final List<BuildingEventModel> _buildingTimeline = [];
  UnmodifiableListView<BuildingEventModel> get buildingTimeline =>
      UnmodifiableListView(_buildingTimeline);

  void addBuildingTimeLineEvent(BuildingEventModel value) {
    _buildingTimeline.add(value);
    // ignore: cascade_invocations
    _buildingTimeline.sort((BuildingEventModel a, BuildingEventModel b) =>
        (a.timestamp).compareTo(b.timestamp));
    udpateStatus();
  }

  bool removeBuildingTimeLineEvent(BuildingEventModel value) {
    var isRemoved = _buildingTimeline.remove(value);
    print('isRemoved: $isRemoved');
    udpateStatus();
    return isRemoved;
  }

  void addBuildingTimeLine(List<BuildingEventModel> value) {
    _buildingTimeline.addAll(value);
    // ignore: cascade_invocations
    _buildingTimeline.sort((BuildingEventModel a, BuildingEventModel b) =>
        (a.timestamp).compareTo(b.timestamp));
    udpateStatus();
  }

  void udpateStatus() {
    if (_buildingTimeline.isNotEmpty) {
      /// Status of the [Building] depends on the type of the last [BuildingEvent]
      _status = _buildingTimeline.last.type;
      _timestamp = _buildingTimeline.last.timestamp;
      if (_buildingTimeline.last.type) {
        /// the number of [activeCases] are all CovidCases ([BuildingEvent] of type true)
        /// after the last sanitation event if any
        _activeCases = 1;
        for (int j = _buildingTimeline.length - 2; j >= 0; j--) {
          /// if hits a sanitation event break
          if (_buildingTimeline[j].type == false) break;
          _activeCases++;
        }
      } else {
        _activeCases = 0;
      }
    }
  }
}
