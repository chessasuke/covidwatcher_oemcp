import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class InfoDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 300, maxHeight: 300),
      child: SimpleDialog(
        backgroundColor: Theme.of(context).dialogBackgroundColor,
        elevation: 30,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: const [
            Icon(FontAwesomeIcons.infoCircle),
            SizedBox(width: 20),
            Text('Information'),
          ],
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: const [
                Icon(FontAwesomeIcons.search),
                SizedBox(width: 10),
                Text("Search structure by name (or code is available)"),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: const [
                Icon(FontAwesomeIcons.filter),
                SizedBox(width: 10),
                Text(
                    "Filter covid and sanitation events by date or number of active cases"),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: const [
                Icon(FontAwesomeIcons.solidBuilding),
                SizedBox(width: 10),
                Text("Show building markers"),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: const [
                Icon(FontAwesomeIcons.mapMarkerAlt),
                SizedBox(width: 10),
                Text("Show non-building structures markers"),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: const [
                Icon(FontAwesomeIcons.replyAll),
                SizedBox(width: 10),
                Text("Reset configuration"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
