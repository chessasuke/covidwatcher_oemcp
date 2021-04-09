import 'package:covid_watcher/data/coord3.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'heatMap.dart';
import 'structure_model.dart';
import '../data/buildingCenters.dart';
import '../data/buildingName.dart';
import '../data/name3.dart';
import '../data/name4.dart';
import '../data/centers4.dart';

/// 4d Structures - Buildings
final buildingProvider = Provider<List<Structure>>((ref) {
  final filter = ref.watch(filterNameProvider).state;
  List<Structure> buildings = [];

  if (filter != null && filter != '') {
    for (int i = 0; i < namesBuild.length; i++) {
      if (namesBuild[i].toLowerCase().contains(filter.toLowerCase())) {
        buildings.add(Structure(
          name: namesBuild[i],
          centroid: centerBuild[i],
        ));
      }
    }
  } else {
    for (int i = 0; i < namesBuild.length; i++) {
      buildings.add(Structure(
        name: namesBuild[i],
        centroid: centerBuild[i],
      ));
    }
  }
  return buildings;
});

/// 4d Structures - non Buildings
final structure4dProvider = Provider<List<Structure>>((ref) {
  final filter = ref.watch(filterNameProvider).state;
  List<Structure> structures4D = [];

  if (filter != null && filter != '') {
    for (int i = 0; i < names4D.length; i++) {
      if (names4D[i].toLowerCase().contains(filter.toLowerCase())) {
        structures4D.add(Structure(
          name: names4D[i],
          centroid: centers4D[i],
        ));
      }
    }
  } else {
    for (int i = 0; i < names4D.length; i++) {
      structures4D.add(Structure(
        name: names4D[i],
        centroid: centers4D[i],
      ));
    }
  }

  return structures4D;
});

/// 3d Structures
final streetsProvider = Provider<List<Street>>((ref) {
  final filter = ref.watch(filterNameProvider).state;
  List<Street> structures3D = [];

  if (filter != null && filter != '') {
    for (int i = 0; i < names3D.length; i++) {
      if (names3D[i].toLowerCase().contains(filter.toLowerCase())) {
        structures3D.add(Street(
          name: names3D[i],
          coordinates: coord3D[i][0],
        ));
      }
    }
  } else {
    for (int i = 0; i < names3D.length; i++) {
      structures3D.add(Street(
        name: names3D[i],
        coordinates: coord3D[i][0],
      ));
    }
  }

  return structures3D;
});
