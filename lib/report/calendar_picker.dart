import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import 'calendar_day.dart';

final datePickerProvider = StateProvider<DateTime>((ref) => DateTime.now());
final timePickerProvider = StateProvider<TimeOfDay>((ref) => TimeOfDay.now());

class CustomDatePicker extends ConsumerWidget {
  List<String> weekDays = ['Su', 'Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa'];

  List<Widget> buildCalendar(DateTime selectedDate) {
    List<Widget> calendar = [];
    DateTime endDate = DateTime.now();
    DateTime startDate = endDate.subtract(const Duration(days: 30));
    DateTime iterator = startDate;

    while (iterator.isBefore(endDate)) {
      List<Widget> row = [];
      for (int i = 0; i < 7; i++) {
        bool isSelectedDay = false;
        bool isDisable = false;

        if (selectedDate.day == iterator.day &&
            selectedDate.month == iterator.month) {
          isSelectedDay = true;
        }
        if (iterator.isAfter(endDate)) {
          isDisable = true;
        }
        row.add(
          CalendarDay(
            datetime: iterator,
            isSelectedDay: isSelectedDay,
            isDisable: isDisable,
          ),
        );
        iterator = iterator.add(const Duration(days: 1));
      }
      calendar.add(Row(children: row));
    }
    return calendar;
  }

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final selectedDate = watch(datePickerProvider).state;
    final selectedTime = watch(timePickerProvider).state;

    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (context) {
              return Container(
                constraints:
                    const BoxConstraints(maxHeight: 300, maxWidth: 250),
                child: SimpleDialog(
                  title: Row(
                    children: const [
                      Text('Pick Date & Time'),
                      SizedBox(width: 20),
                      Flexible(child: Icon(FontAwesomeIcons.calendar))
                    ],
                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /// Weekdays abbr
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: weekDays
                                  .map((e) => Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: SizedBox(
                                          width: 26,
                                          child: Center(
                                            child: Text(e),
                                          ),
                                        ),
                                      ))
                                  .toList(),
                            ),
                            const SizedBox(height: 10),

                            ///
                            /// Actual calendar
                            ///
                            Column(
                              children: buildCalendar(selectedDate),
                            ),
                            const SizedBox(height: 10),

                            ///
                            /// TIME
                            ///
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextButton(
                                  onPressed: () async {
                                    var selectedTime = await showTimePicker(
                                      initialTime: TimeOfDay.now(),
                                      context: context,
                                    );
                                    selectedTime ??= TimeOfDay.now();
                                    context.read(timePickerProvider).state =
                                        selectedTime;
                                  },
                                  child: Row(
                                    children: [
                                      Text(selectedTime.format(context)),
                                      const SizedBox(width: 20),
                                      const Icon(FontAwesomeIcons.solidClock),
                                    ],
                                  )),
                            ),
                            const SizedBox(height: 10),
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('OK'),
                              ),
                            ),
                            const SizedBox(width: 20)
                          ]),
                    )
                  ],
                ),
              );
            });
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: Text(
                '${DateFormat("yyyy-MM-dd").format(DateTime.parse(selectedDate.toString())).toString()}   ${selectedTime.format(context)}',
                style: const TextStyle(fontSize: 24)),
          ),
          const SizedBox(width: 20),
          const Flexible(
            child: Padding(
              padding: EdgeInsets.only(bottom: 4.0),
              child: Icon(FontAwesomeIcons.calendarAlt, size: 20),
            ),
          ),
        ],
      ),
    );
  }
}
