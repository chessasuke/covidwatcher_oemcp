import 'package:covid_watcher/app_themes/responsive.dart';
import 'package:covid_watcher/app_widgets/web_menu.dart';
import 'package:covid_watcher/controllers/navigator_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ReportSentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Stack(children: [
        Align(
            child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                Flexible(
                  child: Text('Report Sent Successfully!',
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 24,
                          fontWeight: FontWeight.bold)),
                ),
                SizedBox(),
                Flexible(
                  child: Text(
                      'The University personnel will review and verify your report. Please have in mind that you might be contacted for additional information. Thanks'),
                ),
              ]),
        )),
        if (!ResponsiveWidget.isMobileScreen(context))
          Positioned(top: 10, left: 10, child: WebMenu())
        else
          IconButton(
              icon: const Icon(FontAwesomeIcons.arrowLeft),
              onPressed: () => NavigatorController.of(context).resetToHome())
      ]),
    ));
  }
}
