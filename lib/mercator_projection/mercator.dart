import 'package:vector_math/vector_math.dart';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:covid_watcher/constants.dart';

// ignore: avoid_classes_with_only_static_members
class Mercator {
  static final double RADIUS_MAJOR = 6378137.0;
  static final double RADIUS_MINOR = 6356752.3142;

  static double xAxisProjection(double input) {
    return radians(input) * Mercator.RADIUS_MAJOR;
  }

  static double yAxisProjection(double input) {
    return math.log(math.tan(math.pi / 4 + radians(input) / 2)) *
        Mercator.RADIUS_MAJOR;
  }

  /// Convert longitude to X value
  static double webMecatorXProj(Size mapSize, double long) {
    return (long + 180) * (mapSize.width / 360);
  }

  /// Convert latitude to Y value
  static double webMecatorYProj(Size mapSize, double lat) {
    double latRad = lat * math.pi / 180;
    var mercN = math.log(math.tan((math.pi / 4) + (latRad / 2)));
    return (mapSize.height / 2) - (mapSize.width * mercN / (2 * math.pi));
  }

  /// Apply a function to the values of a list/List of List
  static List convertListElements2XY(Size screenSize, List list) {
    _util(Size screenSize, List list) {
      for (int i = 0; i < list.length; i++) {
        /// Points
        if (list[i][0].runtimeType != List) {
          List<double> temp = list[i] as List<double>;
          list[i] = projectToXY(screenSize, temp);
        } else {
          _util(screenSize, list[i] as List);
        }
      }
    }

    _util(screenSize, list);
    print('buidl');
    return list;
  }

  /// Function to calculate the
  /// Projection of the long/lat coordinates into X/Y system
  static List<double> projectToXY(Size screenSize, List<double> point) {
    /// Projection into X,Y coordinate
    double x = Mercator.xAxisProjection(point[0]);
    double y = Mercator.yAxisProjection(point[1]);

    /// Offset from screen center
    List<double> rectified = [
      x - convertedCenterX,
      y - convertedCenterY,
    ];
    return rectified;
  }
}
