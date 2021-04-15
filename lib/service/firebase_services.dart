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

final notificationsProvider = FutureProvider.autoDispose((ref) async {
  final UserState userState = ref.watch(userProvider.state);
  if (userState is UserLoaded) {
    ref.maintainState = true;
    try {
      final DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('notification')
          .doc(userState.getUser.getUid)
          .get();
      return NotificationModel.fromDocumentSnapshot(doc);
    } catch (e) {
      print('error: $e');
      return NotificationModel.fromDocumentSnapshot(null);
    }
  } else {
    return null;
  }
});

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
