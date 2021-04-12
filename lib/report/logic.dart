import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid_watcher/models/report_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

List<ReportModel> preprocessReports(String name, String email, String comments,
    DateTime date, TimeOfDay time, List<String> buildings) {
  print('preprocessing reports');

  if (name != null &&
      email != null &&
      date != null &&
      time != null &&
      buildings != null &&
      buildings.isNotEmpty) {
    List<ReportModel> reports = [];

    for (int i = 0; i < buildings.length; i++) {
      reports.add(ReportModel(
        name: name,
        email: email,

        /// Convert to Firebase Timestamp
        timestamp: Timestamp.fromMillisecondsSinceEpoch(
            DateTime(date.year, date.month, date.day, time.hour, time.minute)
                .millisecondsSinceEpoch),
        comments: comments,
        buildingVisited: buildings[i],
      ));
    }
    return reports;
  } else {
    return null;
  }
}
