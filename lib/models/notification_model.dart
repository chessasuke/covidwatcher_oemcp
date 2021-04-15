import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationModel {
  NotificationModel({this.buildingsSubscribed = const []});
  List<String> buildingsSubscribed;

  factory NotificationModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    print('is empty: ${doc.data().isEmpty}');
    return NotificationModel(
        buildingsSubscribed:
            doc.data() != null ? doc.data().keys.toList() : []);
  }
}
