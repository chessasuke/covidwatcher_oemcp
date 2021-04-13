import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<String> updateNotifierBuilding(String building, String uid) async {
  String statusCode = 'error';

  if (building == null || uid == null) return 'building and uid cannot be null';

  print('update notification...');
  print('subscribe to: $building');

  /// Prepare the location of the new case in the DB
  final CollectionReference notificationColl =
      FirebaseFirestore.instance.collection('notification');
  final DocumentReference notificationDocRef = notificationColl.doc(uid);

  final Map<String, dynamic> data = {
    building: null,
  };

  /// Send the data to the location
  try {
    await notificationDocRef
        .set(data, SetOptions(merge: true))
        .then((value) => {statusCode = 'ok'});
  } on FirebaseAuthException catch (e) {
    print('ERROR UPDATING NOTIFICATIONS printing e.code: ${e.code}');
    statusCode = e.message;
  } catch (e) {
    print(e);
  }
  return statusCode;
}

Future<String> removeNotifierBuilding(String building, String uid) async {
  String statusCode = 'error';

  if (building == null || uid == null) return 'building and uid cannot be null';

  print('update notification...');
  print('unsubscribe from: $building');

  /// get the location in the DB
  final CollectionReference notificationColl =
      FirebaseFirestore.instance.collection('notification');
  final DocumentReference notificationDocRef = notificationColl.doc(uid);

  /// Delete the field
  try {
    await notificationDocRef.update({building: FieldValue.delete()}).then(
        (value) => {statusCode = 'ok'});
  } on FirebaseAuthException catch (e) {
    print('ERROR UPDATING NOTIFICATIONS printing e.code: ${e.code}');
    statusCode = e.message;
  } catch (e) {
    print(e);
  }
  return statusCode;
}
