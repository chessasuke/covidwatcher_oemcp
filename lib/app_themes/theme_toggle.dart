import 'package:covid_watcher/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ToggleBrightness extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Theme.of(context).brightness == Brightness.dark
            ? FontAwesomeIcons.solidSun
            : FontAwesomeIcons.solidMoon,
        color: Theme.of(context).brightness == Brightness.dark
            ? Colors.white
            : Colors.black,
      ),
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      color: Colors.white,
      onPressed: () {
        context.read(appThemeProvider).toggle();
      },
    );
  }
}
