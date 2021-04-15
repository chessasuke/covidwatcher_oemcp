import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'building_finder.dart';

class BuildingTile extends StatelessWidget {
  BuildingTile({this.name});
  final String name;

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, child) {
      final buildingsSelected = watch(buildingsAffectedSelected).state;
      return ListTile(
        title: Text(name),
        onTap: () {
          if (!context.read(buildingsAffectedSelected).state.contains(name)) {
            final state = context.read(buildingsAffectedSelected);
            state.state = [...state.state, name];
          } else {
            List<String> temp = context.read(buildingsAffectedSelected).state;
            temp.remove(name);
            final state = context.read(buildingsAffectedSelected);
            state.state = temp;
          }
        },
        trailing: buildingsSelected.contains(name)
            ? const Icon(
                FontAwesomeIcons.checkCircle,
                color: Colors.white,
              )
            : null,
      );
    });
  }
}
