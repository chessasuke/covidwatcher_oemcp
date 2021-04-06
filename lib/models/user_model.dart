import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../service/firebase_services.dart';

//final userProvider = ChangeNotifierProvider.autoDispose<UserModel>((ref) {
//  final userStream = ref.watch(authStateProvider);
//
//  print('user stream is null: ${userStream.data == null}');
//
//  if (userStream.data != null) {
//    print('user stream value is null: ${userStream.data.value == null}');
//  }
//
//  if (userStream.data != null) {
//    if (userStream.data?.value?.uid != null
////      && userStream.data.value.emailVerified
//        ) {
//      final currentUser = UserModel.fromFireBase(userStream.data.value.uid);
//      // ignore: cascade_invocations
//      currentUser.initializeFields();
//      return currentUser;
//    } else {
//      return null;
//    }
//  } else {
//    return null;
//  }
//});

class UserModel //extends ChangeNotifier
{
  static final _firestore = FirebaseFirestore.instance;

  String uid;
  String name;
  String lastName;
  String email;
  String imgURL;

  UserModel({
    this.name,
    this.lastName,
    this.uid,
    this.email,
    this.imgURL,
  });

  // ignore: sort_constructors_first
  factory UserModel.fromDocumentReference({DocumentSnapshot doc}) {
    return UserModel(
      uid: doc.data()['uid'] as String,
      name: doc.data()['name'] as String,
      lastName: doc.data()['lastName'] as String,
      email: doc.data()['email'] as String,
      imgURL: doc.data()['imgURL'] as String,
    );
  }

  String get getUid => uid;
  String get getEmail => email;
  String get getImgURL => imgURL;
  String get getName => name;
  String get getLastName => lastName;

//  factory UserModel.fromFireBase({String uid}) {
//    print('UserModel.fromFireBase uid is: $uid');
//    return UserModel(uid: uid);
//  }
//
//  // ignore: type_annotate_public_apis
//  Future<void> initializeFields() async {
//    print('initializing values: uid is $uid');
//    if (uid != null) {
//      await _firestore.collection('users').doc(uid).get().then((value) {
//        if (value.exists) {
//          if (value.data().containsKey('name')) {
//            name = value.data()['name'] as String ?? '';
//          }
//          if (value.data().containsKey('lastName')) {
//            lastName = value.data()['lastName'] as String ?? '';
//          }
//          if (value.data().containsKey('imgURL')) {
//            imgURL = value.data()['imgURL'] as String ?? '';
//          }
//        } else {
//          return null;
//        }
//      });
////      notifyListeners();
//    }
//  }
//
//  // ignore: type_annotate_public_apis
//  Future<void> setName(String name) async {
//    if (uid != null) {
//      await FirebaseFirestore.instance
//          .collection('users')
//          .doc(uid)
//          .update({'name': name});
//
//      await FirebaseFirestore.instance
//          .collection('users')
//          .doc(uid)
//          .get()
//          .then((DocumentSnapshot value) {
//        if (value.exists) {
//          if (value.data().containsKey('name')) {
//            print('contains name');
//            imgURL = value.data()['name'] as String;
////            notifyListeners();
//          }
//        } else {
//          return null;
//        }
//      });
//    }
//  }
//
//  Future<void> setLastName(String lastname) async {
//    if (uid != null) {
//      await FirebaseFirestore.instance
//          .collection('users')
//          .doc(uid)
//          .update({'name': lastname});
//
//      await FirebaseFirestore.instance
//          .collection('users')
//          .doc(uid)
//          .get()
//          .then((DocumentSnapshot value) {
//        if (value.exists) {
//          if (value.data().containsKey('lastname')) {
//            print('contains lastname');
//            lastName = value.data()['lastname'] as String;
////            notifyListeners();
//          }
//        } else {
//          return null;
//        }
//      });
//    }
//  }
//
//  Future<void> setImgURL(String imageURL) async {
//    if (uid != null) {
//      await FirebaseFirestore.instance
//          .collection('users')
//          .doc(uid)
//          .update({'imgURL': imageURL});
//
//      await FirebaseFirestore.instance
//          .collection('users')
//          .doc(uid)
//          .get()
//          .then((DocumentSnapshot value) {
//        if (value.exists) {
//          if (value.data().containsKey('imgURL')) {
//            print('contains imgURL');
//            imgURL = value.data()['imgURL'] as String;
////            notifyListeners();
//          }
//        } else {
//          return null;
//        }
//      });
//    }
//  }
}
