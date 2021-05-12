import 'package:covid_watcher/user_management/logic/user_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

///---------USER MANAGEMENT----------------

/// Stream connected to firebase - Auth User Status
final firebaseAuthProvider = Provider<FirebaseAuth>((ref) {
  return FirebaseAuth.instance;
});

final authServiceProvider = Provider<UserController>((ref) {
  return UserController(ref.read(firebaseAuthProvider));
});

final authStateProvider = StreamProvider.autoDispose<User>((ref) {
  return ref.watch(authServiceProvider).authStateChanges;
});
