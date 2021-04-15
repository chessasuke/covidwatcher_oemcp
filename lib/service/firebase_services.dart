import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid_watcher/models/notification_model.dart';
import 'package:covid_watcher/models/report_model.dart';
import 'package:covid_watcher/models/user_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../auth/auth_logic.dart';

/// Stream of new covid events
final covidCasesProvider =
    StreamProvider.autoDispose<List<DocumentChange>>((ref) async* {
  final stream = FirebaseFirestore.instance
      .collection('covid-cases')

      /// todo this is not working, it only works the first time is called
//      .where("isVerified", isEqualTo: true)
      .orderBy('timestamp', descending: true)
      .snapshots()
      .distinct();

  /// Yield new DocChanges
  await for (final value in stream) {
    List<DocumentChange> newEvents = [];
    if (value.runtimeType == QuerySnapshot) {
      QuerySnapshot temp = value;
      newEvents = temp.docChanges.toList();
//      print('newEvents size: ${newEvents.length} | what changed: ');
//      newEvents.forEach((element) {
//        print(element.doc.data()['building']);
//      });
    }
    yield newEvents;
  }
});

/// Stream of new sanitation events
final sanitationCasesProvider =
    StreamProvider.autoDispose<List<DocumentChange>>((ref) async* {
  final stream = FirebaseFirestore.instance
      .collection('sanitized-cases')
      .orderBy('timestamp', descending: true)
      .snapshots()
      .distinct();

  /// Yield new DocChanges
  await for (final value in stream) {
    List<DocumentChange> newEvents = [];
    if (value.runtimeType == QuerySnapshot) {
      QuerySnapshot temp = value;
      newEvents = temp.docChanges.toList();
    }
    yield newEvents;
  }
});

/// USER MANAGEMENT
final firebaseAuthProvider = Provider<FirebaseAuth>((ref) {
  return FirebaseAuth.instance;
});

final authServiceProvider = Provider<AuthenticationService>((ref) {
  return AuthenticationService(ref.read(firebaseAuthProvider));
});

final authStateProvider = StreamProvider.autoDispose<User>((ref) {
  return ref.watch(authServiceProvider).authStateChanges;
});

/// Send report to Firebase

Future<String> sendReport(ReportModel report) async {
  print('sending report...');

  print('report building: ${report.buildingVisited}');

  String statusCode = 'error';

  /// Prepare the location of the new case in the DB
  final CollectionReference covidCol =
      FirebaseFirestore.instance.collection('covid-cases');
  String newID = covidCol.doc().id;
  final DocumentReference newCovidCaseRef = covidCol.doc(newID);
  print('id: $newID');

  final Map<String, dynamic> data = {
    'id': newID,
    'userName': report.name,
    'userEmail': report.email,
    'building': report.buildingVisited,
    'timestamp': report.timestamp,
    'isVerified': false,
    'comments': report.comments,
  };

  /// Send the data to the location
  try {
    await newCovidCaseRef.set(data).then((value) => {statusCode = 'success'});
  } on FirebaseAuthException catch (e) {
    print('ERROR SENDING REPORT printing e.code: ${e.code}');
    statusCode = e.message;
  } catch (e) {
    print(e);
  }
  return statusCode;
}

Future<String> sendVisitorReport(ReportModel report) async {
  print('sending report...');

  print('report building: ${report.buildingVisited}');

  String statusCode = 'error';

  /// Prepare the location of the new case in the DB
  final CollectionReference covidCol =
      FirebaseFirestore.instance.collection('visitor-covid-cases');
  String newID = covidCol.doc().id;
  final DocumentReference newCovidCaseRef = covidCol.doc(newID);
  print('id: $newID');

  final Map<String, dynamic> data = {
    'id': newID,
    'userName': report.name,
    'userEmail': report.email,
    'building': report.buildingVisited,
    'timestamp': report.timestamp,
    'isVerified': false,
    'comments': report.comments,
  };

  /// Send the data to the location
  try {
    await newCovidCaseRef.set(data).then((value) => {statusCode = 'success'});
  } on FirebaseAuthException catch (e) {
    print('ERROR SENDING REPORT printing e.code: ${e.code}');
    statusCode = e.message;
  } catch (e) {
    print(e);
  }
  return statusCode;
}

//final AutoDisposeFutureProvider<NotificationModel> notificationsProvider =
//    FutureProvider.autoDispose<NotificationModel>((ref) async {
//  final UserState userState = ref.watch(userProvider.state);
//  if (userState is UserLoaded) {
//    ref.maintainState = true;
//    NotificationModel notificationModel;
//    await FirebaseFirestore.instance
//        .collection('notification')
//        .doc(userState.getUser.getUid)
//        .get()
//        .then((value) {
//      if (value.exists) {
//        print('exists');
//        notificationModel = NotificationModel.fromDocumentSnapshot(value);
//      } else {
//        print('returning empty');
//        notificationModel = NotificationModel.fromDocumentSnapshot(null);
//      }
//    });
//    return notificationModel;
//  } else {
//    return null;
//  }
//});

//Future<String> updateNotifierBuilding(String building, String uid) async {
//  String statusCode = 'error';
//
//  if (building == null || uid == null) return 'building and uid cannot be null';
//
//  print('update notification...');
//  print('subscribe to: $building');
//
//  /// Prepare the location of the new case in the DB
//  final CollectionReference notificationColl =
//      FirebaseFirestore.instance.collection('notification');
//  final DocumentReference notificationDocRef = notificationColl.doc(uid);
//
//  final Map<String, dynamic> data = {
//    building: null,
//  };
//
//  /// Send the data to the location
//  try {
//    await notificationDocRef
//        .set(data, SetOptions(merge: true))
//        .then((value) => {statusCode = 'ok'});
//  } on FirebaseAuthException catch (e) {
//    print('ERROR UPDATING NOTIFICATIONS printing e.code: ${e.code}');
//    statusCode = e.message;
//  } catch (e) {
//    print(e);
//  }
//  return statusCode;
//}
//
//Future<String> removeNotifierBuilding(String building, String uid) async {
//  String statusCode = 'error';
//
//  if (building == null || uid == null) return 'building and uid cannot be null';
//
//  print('update notification...');
//  print('unsubscribe from: $building');
//
//  /// get the location in the DB
//  final CollectionReference notificationColl =
//      FirebaseFirestore.instance.collection('notification');
//  final DocumentReference notificationDocRef = notificationColl.doc(uid);
//
//  /// Delete the field
//  try {
//    await notificationDocRef.update({building: FieldValue.delete()}).then(
//        (value) => {statusCode = 'ok'});
//  } on FirebaseAuthException catch (e) {
//    print('ERROR UPDATING NOTIFICATIONS printing e.code: ${e.code}');
//    statusCode = e.message;
//  } catch (e) {
//    print(e);
//  }
//  return statusCode;
//}

/// Fetches User Info from Firestore given UID
class UserClient {
  static Future<DocumentSnapshot> fetchUserInfo(String uid) async {
    final DocumentSnapshot data = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get()
        .then((DocumentSnapshot value) {
      if (value.exists) {
        return value;
      } else {
        return null;
      }
    });
    return data;
  }
}
