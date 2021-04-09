//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:flutter_riverpod/flutter_riverpod.dart';

//final covidCasesProvider =
//    StreamProvider.autoDispose<QuerySnapshot>((ref) async* {
//  final stream = FirebaseFirestore.instance
//      .collection('covid-cases')
//      .orderBy('timestamp', descending: true)
//      .snapshots()
//      .distinct();
//
//  /// This ensures that we dont trigger a request
//  ref.maintainState = true;
//  await for (final value in stream) {
//    if (value.runtimeType == QuerySnapshot) {
//      QuerySnapshot temp = value;
//      print('QuerySnapshot in covid value size: ${temp.size}');
//    }
//    yield value;
//  }
//});
