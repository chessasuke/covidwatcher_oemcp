import 'package:covid_watcher/auth/logic_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
