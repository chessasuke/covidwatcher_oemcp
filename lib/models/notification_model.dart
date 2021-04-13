import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationModel {
  NotificationModel({this.buildingsSubscribed});
  List<String> buildingsSubscribed;

  factory NotificationModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    return NotificationModel(
        buildingsSubscribed: doc.data().keys.toList() ?? []);
  }
}
