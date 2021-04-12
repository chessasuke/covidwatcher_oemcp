import 'package:covid_watcher/report/building_finder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BuildingTile extends StatefulWidget {
  const BuildingTile({this.name, Key key}) : super(key: key);

  final String name;

  @override
  _BuildingTileState createState() => _BuildingTileState();
}

class _BuildingTileState extends State<BuildingTile> {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, child) {
      final buildingsSelected = watch(buildingsAffectedSelected).state;
      return ListTile(
        title: Text(widget.name),
        onTap: () {
          if (!context
              .read(buildingsAffectedSelected)
              .state
              .contains(widget.name)) {
            context.read(buildingsAffectedSelected).state.add(widget.name);
          } else {
            context.read(buildingsAffectedSelected).state.remove(widget.name);
          }
          print(context
              .read(buildingsAffectedSelected)
              .state
              .contains(widget.name));
          setState(() {});
        },
        trailing: buildingsSelected.contains(widget.name)
            ? const Icon(
                FontAwesomeIcons.checkCircle,
                color: Colors.white,
              )
            : null,
      );
    });
  }
}
