import 'dart:ui';

import 'package:covid_watcher/map/web_menu.dart';
import 'package:covid_watcher/navigator/page_manager.dart';
import 'package:covid_watcher/report/report.dart';
import 'package:covid_watcher/theme/responsive.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../auth/signin.dart';
import 'package:covid_watcher/models/user_state.dart';

class ScreenReport extends StatefulWidget {
  @override
  _ScreenReportState createState() => _ScreenReportState();
}

class _ScreenReportState extends State<ScreenReport> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return SafeArea(child: Scaffold(
        body: SizedBox.expand(child: Consumer(builder: (context, watch, child) {
      /// TODO Enable user status again after finish the form
      final currentUser = watch(userProvider).state;
      print('currentUser: $currentUser');

      return Stack(
        children: [
          if (currentUser != const UserInitial() &&
              currentUser != const UserLoading() &&
              currentUser != const UserError())
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
                    child: TextButton(
                        onPressed: () async {
//                        PageManager.of(context).addSignIn();
                          final response = await showDialog(
                              context: context,
                              builder: (context) {
                                return const SignIn();
                              });
                          print('response: $response');
                          if (response.runtimeType == String &&
                              response == 'update!') {
                            print('set state');
                            setState(() {});
                          }
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
                                padding: EdgeInsets.only(bottom: 16.0, top: 8),
                                child: Text(
                                    'Please sign in to send a Covid Self-Report'),
                              ),
                            ],
                          ),
                        )),
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
