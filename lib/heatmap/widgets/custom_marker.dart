import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import '../models/affected_building_model.dart';
import 'timeline_container.dart';

/// This is the stateful widget that the main application instantiates.
class CustomMarker extends StatelessWidget {
  const CustomMarker({this.affectedBuilding});
  final AffectedBuilding affectedBuilding;

  /// Color of marker depends on the # of active cases
  Color initializeColor(int activeCases) {
    if (activeCases == null || activeCases == 0) {
      return Colors.blue;
    } else if (activeCases == 1) {
      return Colors.orangeAccent;
    } else {
      return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = initializeColor(affectedBuilding.activeCases);
    final Size screenSize = MediaQuery.of(context).size;

    return Positioned(
      left: affectedBuilding.centroid.dx,
      top: affectedBuilding.centroid.dy,
      child: GestureDetector(
        onTap: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return Dialog(
                  child: Container(
                    constraints: BoxConstraints(
                        maxWidth: 500, maxHeight: screenSize.height * 0.98),
                    color: const Color(0xD1117),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          constraints: BoxConstraints(
                              maxHeight: screenSize.height * 0.3),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Flexible(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Flexible(
                                        child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Center(
                                        child: Text(
                                          affectedBuilding.name ?? '',
                                          overflow: TextOverflow.clip,
                                          style: const TextStyle(
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                    )),
                                    Flexible(
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Text(
                                            affectedBuilding.status
                                                ? 'Infected with ${affectedBuilding.activeCases} cases'
                                                : 'Sanitized',
                                            maxLines: 3,
                                            style: TextStyle(
                                                color: affectedBuilding.status
                                                    ? Colors.red
                                                    : Colors.blue)),
                                      ),
                                    ),
                                    Flexible(
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: affectedBuilding.timestamp !=
                                                null
                                            ? Text(
                                                'Last updated ${DateFormat("yyyy-MM-dd  HH:mm:ss").format(DateTime.parse(affectedBuilding.timestamp.toString())).toString()}',
                                                maxLines: 2)
                                            : const SizedBox(),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Flexible(
                                      child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: IconButton(
                                        onPressed: () =>
                                            Navigator.pop(context),
                                        icon: const Icon(
                                            FontAwesomeIcons.timesCircle)),
                                  )),
                                ],
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Container(
                            color: Theme.of(context).dividerColor,
                            width: screenSize.height / 3.5,
                            height: 2,
                          ),
                        ),
                        TimelineContainer(
                            building: affectedBuilding,
                            screenSize: screenSize),
                      ],
                    ),
                  ),
                );
              });
        },
        child: Container(
          child: Icon(
            affectedBuilding.status
                ? FontAwesomeIcons.virus
                : FontAwesomeIcons.pumpMedical,
            color: color,
            size: 15,
          ),
        ),
      ),
    );
  }
}
