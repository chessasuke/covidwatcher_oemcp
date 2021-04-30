import 'package:covid_watcher/user_management/logic/auth_logic.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

///---------USER MANAGEMENT----------------

/// Stream connected to firebase - Auth User Status
final firebaseAuthProvider = Provider<FirebaseAuth>((ref) {
  return FirebaseAuth.instance;
});

final authServiceProvider = Provider<AuthenticationService>((ref) {
  return AuthenticationService(ref.read(firebaseAuthProvider));
});

final authStateProvider = StreamProvider.autoDispose<User>((ref) {
  return ref.watch(authServiceProvider).authStateChanges;
});
