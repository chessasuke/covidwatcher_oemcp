import 'dart:ui';

import 'package:covid_watcher/map/web_menu.dart';
import 'package:covid_watcher/models/user_state.dart';
import 'package:covid_watcher/report/report.dart';
import 'package:covid_watcher/report/visitor_report.dart';
import 'package:covid_watcher/theme/responsive.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../auth/signin.dart';

class ScreenReport extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return SafeArea(child: Scaffold(
        body: SizedBox.expand(child: Consumer(builder: (context, watch, child) {
      final UserState currentUser = watch(userProvider.state);

      return Stack(
        children: [
          if (currentUser is UserLoaded)
            Stack(
              children: [
                ReportForm(),
                if (!ResponsiveWidget.isMobileScreen(context))
                  Positioned(top: 10, left: 10, child: WebMenu()),
              ],
            )
          else
            Align(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text('Self Report',
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 24,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(),
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).buttonColor.withOpacity(0.7),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Column(
                      children: [
                        TextButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return const SignIn();
                                  });
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Text(
                                    'Sign in',
                                    style: Theme.of(context)
                                        .primaryTextTheme
                                        .bodyText1
                                        .copyWith(color: Colors.blue),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                        'Please sign in to send a Covid Self-Report'),
                                  ),
                                ],
                              ),
                            )),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              width: 100,
                              height: 1,
                              color: Theme.of(context).dividerColor),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          VisitorReportForm()));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Text(
                                    'Or Send Visitor Report',
                                    style: Theme.of(context)
                                        .primaryTextTheme
                                        .bodyText1
                                        .copyWith(color: Colors.blue),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                        'Visitor Self-Report doesn\'t require sign in'),
                                  ),
                                ],
                              ),
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          if (!ResponsiveWidget.isMobileScreen(context))
            Positioned(top: 10, left: 10, child: WebMenu()),
        ],
      );
    }))));
  }
}
