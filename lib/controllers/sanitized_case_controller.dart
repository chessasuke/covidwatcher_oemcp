import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid_watcher/models/building_event_model.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final sanitizedCasesProvider =
    StreamProvider.autoDispose<QuerySnapshot>((ref) async* {
  ref.maintainState = true;

  final stream = FirebaseFirestore.instance
      .collection('sanitized-cases')
      .orderBy('timestamp', descending: true)
      .snapshots()
      .distinct();

  /// This ensures that we dont trigger a request
  await for (final value in stream) {
    if (value.runtimeType == QuerySnapshot) {
      QuerySnapshot temp = value;
      print('QuerySnapshot in sanitation value size: ${temp.size}');
    }
    yield value;
  }
});

//final sanitizedCasesProvider = StreamProvider.autoDispose((ref) async* {
////  final controller = ref.watch(sanitizedControllerProvider);
//
//  List<SanitizedCaseModel> newItems = [];
//
//  final Stream stream = FirebaseFirestore.instance
//      .collection('sanitized-cases')
//      .orderBy('timestamp')
//      .snapshots()
//      .distinct();
//
//  final newItemsSubscription =
//      stream.map((event) => event as QuerySnapshot).listen((data) {
//    if (data.docChanges.isNotEmpty) {
//      data.docChanges.forEach((element) {
//        newItems.add(SanitizedCaseModel.fromDocumentSnapshot(element.doc));
//        print('eelement: ${element.doc['building']}');
//      });
//    }
//  }, onDone: () {
//    print("Task Done");
//  }, onError: (error) {
//    print("Some Error");
//  });
//
//  ref.onDispose(newItemsSubscription.cancel);
//
//  print('yielding');
//  print(newItems.length);
//  newItems.forEach((element) {
//    print('element.buildingName: ${element.buildingName}');
//  });
//
//  yield newItems;
//});

//final sanitizedControllerProvider =
//    ChangeNotifierProvider<SanitizedController>((ref) {
//  return SanitizedController();
//});
//
//class SanitizedController extends ChangeNotifier {
//  SanitizedController() {
//    _list = [];
//  }
//  List<SanitizedCaseModel> _list = [];
//  UnmodifiableListView<SanitizedCaseModel> get sanitizedList =>
//      UnmodifiableListView(_list);
//
//  void setSantList(List<SanitizedCaseModel> list) {
//    _list = list;
//    notifyListeners();
//  }
//  void addCase(SanitizedCaseModel newCase) {
//    _list.add(newCase);
//    notifyListeners();
//  }
//
//  void addAllCases(List<SanitizedCaseModel> newCases) {
//    _list.addAll(newCases);
//    notifyListeners();
//  }
//}
