import 'package:covid_watcher/service/firebase_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

final notifierBuildingsSelected =
    StateProvider.autoDispose<List<String>>((ref) => []);

class BuildingSearchTile extends StatelessWidget {
  BuildingSearchTile({this.name});
  final String name;

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, child) {
      final buildingsSelected = watch(notifierBuildingsSelected).state;
      return ListTile(
        title: Text(name),
        onTap: () {
          if (!context.read(notifierBuildingsSelected).state.contains(name)) {
            final state = context.read(notifierBuildingsSelected);
            state.state = [...state.state, name];
          } else {
            List<String> temp = context.read(notifierBuildingsSelected).state;
            temp.remove(name);
            final state = context.read(notifierBuildingsSelected);
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
