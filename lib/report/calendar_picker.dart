import 'package:covid_watcher/report/calendar_day.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

final datePickerProvider = StateProvider<DateTime>((ref) => DateTime.now());

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
        iterator = iterator.add(Duration(days: 1));
      }
      calendar.add(Row(children: row));
    }
    return calendar;
  }

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final selectedDate = watch(datePickerProvider).state;

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
                      Text('Pick Date'),
                      SizedBox(width: 20),
                      Icon(FontAwesomeIcons.calendar)
                    ],
                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
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
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: buildCalendar(selectedDate),
                      ),
                    )
                  ],
                ),
              );
            });
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
              DateFormat("yyyy-MM-dd")
                  .format(DateTime.parse(selectedDate.toString()))
                  .toString(),
              style: TextStyle(fontSize: 24)),
          const SizedBox(width: 20),
          const Padding(
            padding: EdgeInsets.only(bottom: 4.0),
            child: Icon(FontAwesomeIcons.calendarAlt, size: 20),
          ),
        ],
      ),
    );
  }
}
