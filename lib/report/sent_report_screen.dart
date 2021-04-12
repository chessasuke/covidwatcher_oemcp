import 'package:covid_watcher/navigator/page_manager.dart';
import 'package:flutter/material.dart';
import 'package:covid_watcher/map/web_menu.dart';
import 'package:covid_watcher/theme/responsive.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ReportSentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Stack(children: [
        Align(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
              const Text('Report Sent Successfully!',
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 24,
                      fontWeight: FontWeight.bold)),
              const SizedBox(),
              const Text(
                  'The University personnel will review and verify your report. Please have in mind that you might be contacted for additional information. Thanks'),
            ])),
        if (!ResponsiveWidget.isMobileScreen(context))
          Positioned(top: 10, left: 10, child: WebMenu())
        else
          IconButton(
              icon: const Icon(FontAwesomeIcons.arrowLeft),
              onPressed: () => PageManager.of(context).resetToHome())
      ]),
    ));
  }
}
