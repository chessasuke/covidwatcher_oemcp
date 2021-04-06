import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final covidCasesProvider =
    StreamProvider.autoDispose<QuerySnapshot>((ref) async* {
  final stream = FirebaseFirestore.instance
      .collection('covid-cases')
      .orderBy('timestamp', descending: true)
      .snapshots()
      .distinct();

  /// This ensures that we dont trigger a request
  ref.maintainState = true;
  await for (final value in stream) {
    if (value.runtimeType == QuerySnapshot) {
      QuerySnapshot temp = value;
      print('QuerySnapshot in covid value size: ${temp.size}');
    }
    yield value;
  }
});

//final covidCasesProvider = StateProvider((ref) {
//  final controller = ref.watch(covidControllerProvider);
//
//  FirebaseFirestore.instance
//      .collection('covid-cases')
//      .orderBy('timestamp', descending: true)
//      .snapshots()
//      .listen((event) {
//    if (event.docChanges.isNotEmpty) {
//      print('covid');
//      print(event.docChanges.length);
//      List<CovidCaseModel> tempList = [];
//      event.docChanges.forEach((element) {
//        var temp = CovidCaseModel.fromDocumentSnapshot(element.doc);
//        print('new covid item: ${temp.buildingName}');
//        tempList.add(temp);
//      });
//      controller.setCovidList(tempList);
//    } else
//      print('empty'); //    if (event.docChanges.isNotEmpty) {
////      print('new covid data with size: ${event.docChanges.length}');
////      event.docChanges.forEach((element) {
////        var temp = CovidCaseModel.fromDocumentSnapshot(element.doc);
////        print('new covid item: ${temp.buildingName}');
////        controller.addCase(temp);
////      });
////    } else
////      print('no data');
//  });
//  print(
//      'returning from covidCasesProvider with length: ${controller.covidList.length}');
//
//  return controller;
//});
//
//final covidControllerProvider = ChangeNotifierProvider((ref) {
//  return CovidController();
//});
//
//class CovidController extends ChangeNotifier {
//  CovidController();
//
//  List<CovidCaseModel> _list = [];
//  UnmodifiableListView<CovidCaseModel> get covidList =>
//      UnmodifiableListView(_list);
//
//  void setCovidList(List<CovidCaseModel> list) {
//    _list = list;
//  }
//
////  void addCase(CovidCaseModel newCase) {
////    _list.add(newCase);
////  }
////
////  void addAllCases(List<CovidCaseModel> newCases) {
////    _list.addAll(newCases);
////  }
//}
