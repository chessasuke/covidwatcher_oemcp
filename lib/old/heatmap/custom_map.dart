//import 'dart:ui';
//import 'package:flutter/cupertino.dart';
//import 'package:flutter/material.dart';
//
//class CustomMap2 extends CustomPainter {
//  Size screenSize;
//  List coordinates;
//  Offset delta;
//  double scale;
//
//  CustomMap2({
//    this.scale,
//    this.delta = Offset.zero,
//    this.screenSize,
//    this.coordinates,
//  });
//
//  @override
//  void paint(Canvas canvas, Size size) {
//    canvas.drawColor(Colors.black, BlendMode.darken);
//
//    /// If enters to an if condition then it's an Offset (List<double> size 2);
//    for (int i = 0; i < coordinates.length; i++) {
//      if (coordinates[i] is List<List<List<double>>>) {
//        paint3d(canvas, coordinates[i] as List<List<List<double>>>, size);
//      }
//    }
//  }
//
//  /// Paints the coordinates provided by dataCoordinate
//  void paint3d(Canvas canvas, List<List<List<double>>> inBorder, Size size) {
//    final Paint paintBorder = Paint()
//      ..color = Colors.white
//      ..strokeCap = StrokeCap.round
//      ..strokeWidth = 1.0;
//
//    for (int i = 0; i < inBorder.length; i++) {
//      /// Paint polygon using lines
//      /// before I was using Path but was extremely expensive(slow)
//      ///
//      for (int j = 0; j < inBorder[i].length - 1; j++) {
//        Offset firstPt = Offset(inBorder[i][j][0] + size.width / 2,
//            (-inBorder[i][j][1]) + size.height / 1.2);
//        Offset secondPt = Offset(inBorder[i][j + 1][0] + size.width / 2,
//            (-inBorder[i][j + 1][1]) + size.height / 1.2);
//
//        /// Drawing lines turned out to be way less expensive than drawing Path
//        canvas.drawLine(firstPt, secondPt, paintBorder);
//      }
//    }
//  }
//
//  @override
//  bool shouldRepaint(CustomMap2 oldDelegate) {
//    return false;
//  }
//}
