import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final filterRateProvider = StateProvider<String>((ref) => '+0');

class DropdownRateFilter extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final dropdownValue = watch(filterRateProvider).state;
    return Container(
      constraints: const BoxConstraints(maxWidth: 200, maxHeight: 100),
      child: Column(
        children: [
          const Flexible(child: Text('Filter by Rate')),
          Flexible(
            child: SizedBox(
              width: 150,
              child: DropdownButton(
                value: dropdownValue ?? '+0',
                icon: const Icon(Icons.arrow_downward),
                iconSize: 24,
                elevation: 16,
                style: TextStyle(color: Theme.of(context).accentColor),
                underline: Container(
                  height: 2,
                  color: Theme.of(context).accentColor,
                ),
                onChanged: (String newValue) {
                  context.read(filterRateProvider).state = newValue;
                },
                items: ['+0', '+2', '+5', '+10'].map((String value) {
                  return DropdownMenuItem(
                    value: value,
                    child: Text(
                      value,
                      overflow: TextOverflow.clip,
                    ),
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
