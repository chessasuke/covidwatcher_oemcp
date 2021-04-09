//import 'package:flutter_riverpod/flutter_riverpod.dart';
//
//import '../models/affected_building_model.dart';
//import 'building_controller.dart';
//
//final filterProvider =
//    Provider.autoDispose.family<List<Building>, String>((ref, filter) {
//  final buildingController = ref.watch(buildingProvider);
//
//  /// If [filter] is not empty, filter and return the list
//  if (filter != null && filter != '') {
//    print('filter: $filter');
//    final List<Building> buildingsFiltered = []..addAll(
//        buildingController.buildings.where((Building element) =>
//            element.name.toLowerCase().contains(filter.toLowerCase())));
//    return buildingsFiltered;
//  }
//
//  /// else return the list
//  else {
//    return buildingController.buildings;
//  }
//});
