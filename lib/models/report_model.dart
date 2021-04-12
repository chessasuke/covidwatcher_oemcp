import 'package:cloud_firestore/cloud_firestore.dart';

class ReportModel {
  ReportModel(
      {this.email,
      this.name,
      this.timestamp,
      this.comments,
      this.buildingVisited});

  final String name;
  final String email;
  final Timestamp timestamp;
  final String comments;
  final String buildingVisited;
}
