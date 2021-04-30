import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../local_data/buildingCenters.dart';
import '../local_data/buildingName.dart';
import '../local_data/centers4.dart';
import '../local_data/coord3.dart';
import '../local_data/name3.dart';
import '../local_data/name4.dart';
import '../models/structure_model.dart';
import 'heatmap_providers.dart';


/// THIS FILE CONTAINS PROVIDERS CONNECTED TO THE STRUCTURES MODELS (buildings, streets)


/// 4d Structures - Buildings
final buildingProvider = Provider<List<StructureModel>>((ref) {
  final filter = ref.watch(filterNameProvider).state;
  List<StructureModel> buildings = [];

  if (filter != null && filter != '') {
    for (int i = 0; i < namesBuild.length; i++) {
      if (namesBuild[i].toLowerCase().contains(filter.toLowerCase())) {
        buildings.add(StructureModel(
          name: namesBuild[i],
          centroid: centerBuild[i],
        ));
      }
    }
  } else {
    for (int i = 0; i < namesBuild.length; i++) {
      buildings.add(StructureModel(
        name: namesBuild[i],
        centroid: centerBuild[i],
      ));
    }
  }
  return buildings;
});

/// 4d Structures - non Buildings
final structure4dProvider = Provider<List<StructureModel>>((ref) {
  final filter = ref.watch(filterNameProvider).state;
  List<StructureModel> structures4D = [];

  if (filter != null && filter != '') {
    for (int i = 0; i < names4D.length; i++) {
      if (names4D[i].toLowerCase().contains(filter.toLowerCase())) {
        structures4D.add(StructureModel(
          name: names4D[i],
          centroid: centers4D[i],
        ));
      }
    }
  } else {
    for (int i = 0; i < names4D.length; i++) {
      structures4D.add(StructureModel(
        name: names4D[i],
        centroid: centers4D[i],
      ));
    }
  }

  return structures4D;
});

/// 3d Structures
final streetsProvider = Provider<List<StreetModel>>((ref) {
  final filter = ref.watch(filterNameProvider).state;
  List<StreetModel> structures3D = [];

  if (filter != null && filter != '') {
    for (int i = 0; i < names3D.length; i++) {
      if (names3D[i].toLowerCase().contains(filter.toLowerCase())) {
        structures3D.add(StreetModel(
          name: names3D[i],
          coordinates: coord3D[i][0],
        ));
      }
    }
  } else {
    for (int i = 0; i < names3D.length; i++) {
      structures3D.add(StreetModel(
        name: names3D[i],
        coordinates: coord3D[i][0],
      ));
    }
  }

  return structures3D;
});
