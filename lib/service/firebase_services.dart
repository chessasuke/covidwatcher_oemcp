import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
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
