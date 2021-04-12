//import 'package:flutter/material.dart';
//
//import '../models/affected_building_model.dart';
//import 'marker_timeline.dart';
//
//class TimelineContainer extends StatefulWidget {
//  const TimelineContainer({@required this.building, this.screenSize});
//  final AffectedBuilding building;
//  final Size screenSize;
//  @override
//  _TimelineContainerState createState() => _TimelineContainerState();
//}
//
//class _TimelineContainerState extends State<TimelineContainer> {
//  bool viewMore = false;
//  @override
//  Widget build(BuildContext context) {
//    return AnimatedContainer(
//      constraints: viewMore == false
//          ? BoxConstraints(maxHeight: widget.screenSize.height * 0.3)
//          : BoxConstraints(maxHeight: widget.screenSize.height * 0.55),
//      duration: const Duration(milliseconds: 500),
//      child: viewMore == false
//          ? TextButton(
//              onPressed: () {
//                setState(() {
//                  viewMore = true;
//                });
//              },
//              child: Text('View More',
//                  style: TextStyle(color: Theme.of(context).accentColor)),
//            )
//          : Column(
//              mainAxisSize: MainAxisSize.min,
//              children: [
//                Center(
//                    child: TextButton(
//                  onPressed: () {
//                    setState(() {
//                      viewMore = false;
//                    });
//                  },
//                  child: Text('View Less',
//                      style: TextStyle(color: Theme.of(context).accentColor)),
//                )),
//                Flexible(
//                  child: CustomScrollView(slivers: [
//                    MarkerTimeline(
//                      buildingTimeline:
//                          widget.building.buildingTimeline.reversed.toList(),
//                    ),
//                  ]),
//                ),
//              ],
//            ),
//    );
//  }
//}
