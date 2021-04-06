import 'package:cloud_firestore/cloud_firestore.dart';

/// This class organizes the data fetched from Firestore
/// And it's the unit to construct the building timeline
/// The type field determines if it's a Sanitation(false) or Covid(true) Event

class BuildingEventModel {
  BuildingEventModel(
      {this.buildingName, this.timestamp, this.comments, this.type, this.id});

  final String id;
  final String buildingName;
  final DateTime timestamp;
  final String comments;
  final bool type;

  factory BuildingEventModel.fromDocumentSnapshot(DocumentSnapshot doc,
      {bool type}) {
    return BuildingEventModel(
      id: doc.data()['id'] as String,
      buildingName: doc.data()['building'] as String,
      timestamp: DateTime.fromMillisecondsSinceEpoch(
          doc.data()['timestamp'].millisecondsSinceEpoch as int),
      comments: doc.data()['comments'] as String,
      type: type,
    );
  }
}
