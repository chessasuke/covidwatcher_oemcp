import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:url_launcher/url_launcher.dart';

class AuthenticationService {
  final FirebaseAuth _auth;
  AuthenticationService(this._auth);

  Stream<User> get authStateChanges => _auth.authStateChanges();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Only letters, digits and period
  static String validateEmail(String value) {
    final RegExp regExp = RegExp(r'^[a-zA-Z0-9.]+$');

    if (value != null) {
      value = value.trim();
      if (value.isEmpty) {
        return 'Email can\'t be empty';
      } else if (!regExp.hasMatch(value)) {
        return 'Email bad format';
      }
    }
    return null;
  }

  // ignore: public_member_api_docs
  static bool isEmailError(String text) {
    if (AuthenticationService.validateEmail(text) == 'Email bad format') {
      return true;
    } else {
      return false;
    }
  }

  static String validatePassword(String pass1) {
    if (pass1 != null) {
      pass1 = pass1.trim();
      if (pass1.isEmpty) {
        return 'Password can\'t be empty';
      } else if (pass1.length < 6) {
        return 'Length of password should be greater than 5';
      }
    }
    return null;
  }

  static String validatePassword2(String pass1, String pass2) {
    if (pass2 != null && pass1 != null) {
      if (pass1.isEmpty || pass2.isEmpty) {
        return 'Password can\'t be empty';
      }
      if (pass1 == pass2 && pass2.length > 5) {
        return 'ok';
      } else {
        return 'Passwords don\'t match';
      }
    }
    return null;
  }

  /// Create username if is available and auth registration was successful.
  /// Returns String statusCode. Username are created in two collections users and indexes, in indexes as the path and storing the uid in the correspondent document, this way is assured that usernames are unique
  Future<String> createUser(String name, String lastname, String uid,
      String email, String password) async {
    String statusCode = 'Error';

    /// prepare map for uploading
    final Map<String, dynamic> userData = <String, dynamic>{};
    if (name != null) userData['name'] = name;
    if (lastname != null) userData['lastname'] = lastname;
    if (uid != null) userData['uid'] = uid;
    if (email != null) userData['email'] = email;

    /// Make sure username is unique
    if (uid != null && email != null) {
      // reference to document in users collection
      final CollectionReference userCol = _firestore.collection('users');
      final DocumentReference userRef = userCol.doc(uid);

      // transaction to write to both indexes and users collections
      try {
        await _firestore.runTransaction((Transaction transaction) {
          return transaction.get(userRef).then((DocumentSnapshot value) {
            if (value.exists) {
              print('Already exists');
            } else {
              print('Creating account');
              transaction.set(userRef, userData);
              statusCode = 'ok';
            }
          });
        });
      } on FirebaseAuthException catch (e) {
        print('ERROR WITH TRANSACTION printing e.code: ${e.code}');
        statusCode = e.message;
      } catch (e) {
        print(e);
      }
    }

    print('statusCode before exiting createUser: $statusCode');
    return statusCode;
  }

  /// Register the new auth user and calls createUser() to store unique username in firestore, if createUser fails the auth User is deleted.
  Future<String> signUp(
      String name, String lastname, String email, String pass) async {
    String statusCode = 'SetToError';

    print('signup');

    if (email != null && pass != null) {
      try {
        final UserCredential userCredential = await _auth
            .createUserWithEmailAndPassword(email: email, password: pass);

        if (email != null && pass != null && userCredential.user.uid != null) {
          statusCode = await createUser(
              name, lastname, userCredential.user.uid, email, pass);

          // ********************************************************
          /// ALL WENT OK
          if (statusCode == 'ok') {
            await userCredential.user.sendEmailVerification();
          }
          // ********************************************************
          else {
            print('[Error] statusCode: $statusCode');
            print('deleting user auth...');
            await userCredential.user.delete();
          }
        } else {
          statusCode = 'email or password cannot be null';
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          statusCode = 'The password provided is too weak.';
        } else if (e.code == 'email-already-in-use') {
          statusCode = 'The account already exists for that email.';
        } else {
          print('Failed with error code: ${e.code}');
          print(e.message);
          statusCode = e.message;
        }
      } catch (e) {
        print(e);
      }
    } else {
      if (email == null) {
        statusCode = 'email cannot be empty';
      } else if (pass == null) statusCode = 'password cannot be empty';
    }
    return statusCode;
  }

  /// Logs In the user if credentials exists and email is verified
  /// Returns String statusCode, which is ok if success or the error.message if there was an exception.
  Future<String> signIn(String email, String password) async {
    String statusCode;

    if (email != null && password != null) {
      try {
        final UserCredential userCredential = await _auth
            .signInWithEmailAndPassword(email: email, password: password);
        if (userCredential.user.emailVerified) {
          print('Successfully logged in');
          assert(userCredential.user.uid != null);
          assert(userCredential.user.email != null);

          statusCode = 'ok';
        } else {
          await userCredential.user.sendEmailVerification();
          print('[Email not verified] sending verification email...');
          statusCode =
              'Email not verified, please go to your inbox and verify your email, we sent you a verification email';
        }
      } on FirebaseAuthException catch (e) {
        print('Failed with error code: ${e.code}');
        statusCode = e.message;
      }
    } else {
      statusCode = 'email/password empty';
    }
    return statusCode;
  }

  Future<String> resetPassword(String email) async {
    String statusCode = 'Unknown error';

    try {
      await _auth.sendPasswordResetEmail(email: email).then((value) {
        statusCode = 'ok';
      }).catchError((dynamic onError) {
        statusCode = onError.toString();
        print(onError);
      });
    } on FirebaseAuthException catch (e) {
      print('Failed with error code: ${e.code}');
      statusCode = e.message;
    } catch (e) {
      print(e);
    }

    return statusCode;
  }

  /// Signs out the user and set user info to null
  Future<String> signOut() async {
    try {
      await _auth.signOut();
      return 'User signed out';
    } catch (e) {
      print(e);
      return 'Error at sign out';
    }
  }

  Future<UserCredential> signInAgain(String email, String password) async {
    final UserCredential userCredential = await _auth
        .signInWithEmailAndPassword(email: email, password: password);
    return userCredential;
  }

  /// Delete user account
  Future<String> deleteAccount(String uid) async {
    String statusCode = 'ok';

    if (uid != null) {
      print('uid: $uid');

      // reference to document in users collection
      final CollectionReference userCol =
          FirebaseFirestore.instance.collection('users');
      final DocumentReference userRef = userCol.doc(uid);

      // transaction to write to both indexes and users collections
      try {
        await FirebaseFirestore.instance
            .runTransaction((Transaction transaction) {
          return transaction.get(userRef).then((DocumentSnapshot value) {
            if (value.exists) {
              transaction.delete(userRef);
              print('statusCode (transaction if): $statusCode');
            } else {
              statusCode = 'User does not exist';
              print('statusCode (transaction else): $statusCode');
            }
          });
        });
      } on FirebaseAuthException catch (e) {
        print('ERROR WITH TRANSACTION printing e.code: ${e.code}');
        statusCode = e.message;
        print('statusCode (transaction fire-exception): $statusCode');
      } catch (e) {
        print(e);
        statusCode = e.toString();
        print('statusCode (transaction catch): $statusCode');
      }

      if (statusCode == 'ok') {
        try {
          await _auth.currentUser.delete().then((value) {
            statusCode = 'ok';
            print('statusCode (auth try): $statusCode');
          });
        } on FirebaseAuthException catch (e) {
          print('Error deleting UserAuthe e.code: ${e.code}');
          statusCode = e.message;
          print('statusCode (auth fire-exception): $statusCode');
        } catch (e) {
          print(e);
          statusCode = e.toString();
          print('statusCode (auth catch): $statusCode');
        }
      }
    }

    return statusCode;
  }

  static Future<void> launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: true,
        forceWebView: true,
        headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }
}
