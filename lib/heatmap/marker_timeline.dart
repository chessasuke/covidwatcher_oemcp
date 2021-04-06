import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../models/building_event_model.dart';

class MarkerTimeline extends StatelessWidget {
  const MarkerTimeline({this.buildingTimeline});

  final List<BuildingEventModel> buildingTimeline;

  @override
  Widget build(BuildContext context) {
    return buildingTimeline.isNotEmpty
        ? _Timeline(buildingTimeline: buildingTimeline)
        : SliverFillRemaining(
            child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.white54,
                      Colors.white,
                    ],
                  ),
                ),
                child: Center(
                    child: Container(
                        width: 100,
                        height: 100,
                        child: const CircularProgressIndicator()))),
          );
  }
}

class _Timeline extends StatelessWidget {
  const _Timeline({Key key, this.buildingTimeline}) : super(key: key);

  final List<BuildingEventModel> buildingTimeline;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          final int itemIndex = index ~/ 2;
          final BuildingEventModel event = buildingTimeline[itemIndex];

          final bool isLeftAlign = itemIndex.isEven;

          final _TimelineChild child = _TimelineChild(
            type: event.type,
            comment: event.comments,
            timestamp: event.timestamp,
            isLeftAlign: isLeftAlign,
          );

          final bool isFirst = itemIndex == 0;
          final bool isLast = itemIndex == buildingTimeline.length - 1;
          double indicatorY;

          /// if is odd return the horizontal divider which is part of the timeline edges
          if (index.isOdd) {
            return const TimelineDivider(
              color: Colors.black,
              thickness: 5,
              begin: 0.1,
              end: 0.9,
            );
          }

          if (isFirst) {
            indicatorY = 0.2;

            /// Top
          } else if (isLast) {
            indicatorY = 0.8;

            /// Bottom
          } else {
            indicatorY = 0.5;

            /// Middle
          }

          /// if is NOT odd return the timeline child
          return TimelineTile(
            alignment: TimelineAlign.manual,
            endChild: isLeftAlign ? child : null,
            startChild: isLeftAlign ? null : child,
            lineXY: isLeftAlign ? 0.1 : 0.9,

            /// left to Right
            isFirst: isFirst,
            isLast: isLast,
            indicatorStyle: IndicatorStyle(
              width: 40,
              height: 40,

              /// Percent where the indicator should be positioned on line, from left to right
              indicatorXY: indicatorY,

              /// Indicator value, a Widget
              indicator: _TimelineIndicator(
                  icon: event.type
                      ? FontAwesomeIcons.virus
                      : FontAwesomeIcons.pumpMedical),
            ),
            beforeLineStyle: const LineStyle(
              color: Colors.black,
              thickness: 5,
            ),
          );
        },
        childCount: max(0, buildingTimeline.length * 2 - 1),
      ),
    );
  }
}

class _TimelineIndicator extends StatelessWidget {
  const _TimelineIndicator({Key key, this.icon}) : super(key: key);
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.black,
      ),
      child: Icon(
        icon,
        color: Colors.white,
      ),
    );
  }
}

class _TimelineChild extends StatelessWidget {
  const _TimelineChild(
      {Key key, this.timestamp, this.comment, this.type, this.isLeftAlign})
      : super(key: key);

  final DateTime timestamp;
  final String comment;
  final bool type;
  final bool isLeftAlign;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment:
          isLeftAlign ? CrossAxisAlignment.start : CrossAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text(type ? 'Infection' : 'Sanitation'),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text(comment ?? ''),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text(DateFormat("yyyy-MM-dd  HH:mm:ss")
                  .format(DateTime.parse(timestamp.toString()))
                  .toString() ??
              ''),
        ),
      ],
    );
  }
}
