import 'package:flutter/material.dart';

class StructureModel {
  StructureModel({
    this.coordinate,
    this.name,
    this.centroid,
  });

  /// Name of the building provided by dataCoordinate
  final String name;

  /// The first Offset provided by dataCoordinate for this building
  /// It's where the marker will appear
  final Offset coordinate;

  /// The centroid is calculated by taking the average of all
  /// coordinates of the polygon. This is not ideal, since polygons
  /// with a hole in the center for example will get the center wrong
  /// but it's enough for this use case (UTD CAMPUS MAP)
  final List<double> centroid;
}

class StreetModel {
  final String name;
  final List coordinates;

  StreetModel({this.name, this.coordinates});
}
