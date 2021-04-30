import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
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
}
