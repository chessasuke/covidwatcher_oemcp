//import 'package:covid_watcher/report/building_finder.dart';
//import 'package:flutter/cupertino.dart';
//import 'package:flutter/material.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//import 'package:flutter_riverpod/flutter_riverpod.dart';
//
//class BuildingAdded extends StatelessWidget {
//  final String name;
//  const BuildingAdded({@required this.name, Key key}) : super(key: key);
//  @override
//  Widget build(BuildContext context) {
//    return Chip(
//      avatar: Text(name),
//      label: IconButton(
//          icon: const Icon(
//            FontAwesomeIcons.times,
//            size: 14,
//          ),
//          onPressed: () {
//            context.read(buildingsAffectedSelected).state.remove(name);
//          }),
//    );
////      Row(
////      mainAxisSize: MainAxisSize.min,
////      children: [
////        Text(name),
////        const SizedBox(width: 6),
////        IconButton(
////            icon: const Icon(FontAwesomeIcons.times),
////            onPressed: () {
////              context.read(buildingsAffectedSelected).state.remove(name);
////            })
////      ],
////    );
//  }
//}
