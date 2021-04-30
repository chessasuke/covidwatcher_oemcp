import 'package:covid_watcher/providers/heatmap_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DropdownDateFilter extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final dropdownValue = watch(filterDateProvider).state;
    return Container(
      constraints: const BoxConstraints(maxWidth: 200, maxHeight: 100),
      child: Column(
        children: [
          const Flexible(child: Text('Filter by Date')),
          Flexible(
            child: SizedBox(
              width: 150,
              child: DropdownButton(
                value: dropdownValue ?? 'Last Month',
                icon: const Icon(Icons.arrow_downward),
                iconSize: 24,
                elevation: 16,
                style: TextStyle(color: Theme.of(context).accentColor),
                underline: Container(
                  height: 2,
                  color: Theme.of(context).accentColor,
                ),
                onChanged: (String newValue) {
                  context.read(filterDateProvider).state = newValue;
                },
                items: ['Last Day', 'Last Week', 'Last 2 Weeks', 'Last Month']
                    .map((String value) {
                  return DropdownMenuItem(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
