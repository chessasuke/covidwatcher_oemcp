import 'package:covid_watcher/map/web_menu.dart';
import 'package:covid_watcher/report/report_oemcp.dart';
import 'package:covid_watcher/theme/responsive.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ScreenReport extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return SafeArea(child: Scaffold(
        body: SizedBox.expand(child: Consumer(builder: (context, watch, child) {
      return Stack(
        children: [
          ReportFormOemcp(),
          if (!ResponsiveWidget.isMobileScreen(context))
            Positioned(top: 10, left: 10, child: WebMenu()),
        ],
      );
    }))));
  }
}
