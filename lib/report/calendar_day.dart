import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import 'calendar_picker.dart';

class CalendarDay extends StatefulWidget {
  CalendarDay({@required this.datetime, this.isSelectedDay, this.isDisable});
  final DateTime datetime;
  final bool isSelectedDay;
  final bool isDisable;

  @override
  _CalendarDayState createState() => _CalendarDayState();
}

class _CalendarDayState extends State<CalendarDay> {
  bool isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (enterEvent) {
        if (!widget.isDisable) {
          setState(() => isHovering = true);
        }
      },
      onExit: (exitEvent) {
        if (!widget.isDisable) {
          setState(() => isHovering = false);
        }
      },
      child: GestureDetector(
        onTap: () {
          if (!widget.isDisable) {
            print(widget.datetime.toString());
            context.read(datePickerProvider).state = widget.datetime;
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              color: widget.isDisable
                  ? Colors.grey
                  : widget.isSelectedDay
                      ? Colors.blue
                      : isHovering
                          ? Colors.blue.withOpacity(0.7)
                          : Colors.transparent,
            ),
            width: 26,
            child: Center(
              child: Text(DateFormat("dd")
                  .format(DateTime.parse(widget.datetime.toString()))
                  .toString()),
            ),
          ),
        ),
      ),
    );
  }
}
