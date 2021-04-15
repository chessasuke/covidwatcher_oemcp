import 'dart:ui';

import 'package:covid_watcher/animation.dart';
import 'package:covid_watcher/auth/auth_logic.dart';
import 'package:covid_watcher/map/web_menu.dart';
import 'package:covid_watcher/models/report_model.dart';
import 'package:covid_watcher/navigator/page_manager.dart';
import 'package:covid_watcher/report/building_finder.dart';
import 'package:covid_watcher/report/calendar_picker.dart';
import 'package:covid_watcher/report/logic.dart';
import 'package:covid_watcher/service/firebase_services.dart';
import 'package:covid_watcher/theme/responsive.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class VisitorReportForm extends ConsumerWidget {
  final TextEditingController _controllerComments = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerName = TextEditingController();

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            child: Center(
              child: Container(
                width: !ResponsiveWidget.isMobileScreen(context)
                    ? screenSize.width * 0.7
                    : screenSize.width,
                height: screenSize.height,
                decoration: BoxDecoration(
                    color: Theme.of(context).buttonColor.withOpacity(
                        0.7), //                color: Color(0xEB3A60),
                    border: Border(
                      left: BorderSide(color: Theme.of(context).dividerColor),
                      right: BorderSide(color: Theme.of(context).dividerColor),
                    )),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          child: Container(
                            width: !ResponsiveWidget.isMobileScreen(context)
                                ? screenSize.width * 0.7
                                : screenSize.width,
                            constraints: const BoxConstraints(maxHeight: 250),
                            child: Stack(
                              children: [
                                Positioned(
                                  top: 30,
                                  child: Container(
                                      constraints: const BoxConstraints(
                                          maxHeight: 210, maxWidth: 325),
                                      child: const AnimationExample()),
                                ),
                                Positioned(
                                    top: 30,
                                    left: (screenSize.width * 0.7) / 2,
                                    child: const Padding(
                                      padding: EdgeInsets.only(top: 50.0),
                                      child: Text('Self Report',
                                          style: TextStyle(
                                              color: Colors.lightBlueAccent,
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold)),
                                    )),
                                if (ResponsiveWidget.isMobileScreen(context))
                                  Positioned(
                                      top: 10,
                                      left: 10,
                                      child: IconButton(
                                          icon: const Icon(
                                            FontAwesomeIcons.arrowLeft,
                                            color: Colors.blue,
                                          ),
                                          onPressed: () =>
                                              Navigator.pop(context))),
                              ],
                            ),
                          ),
                        ),

                        /// DIVIDER
                        const DividerCustom(),

                        /// NAME
                        const Padding(
                          padding: EdgeInsets.all(4),
                          child: Text('Your Name',
                              style: TextStyle(color: Colors.blue)),
                        ),
                        Flexible(
                          child: TextField(
                              controller: _controllerName,
                              decoration:
                                  const InputDecoration(hintText: 'Name'),
                              style: TextStyle(
                                  fontSize: 24,
                                  color: Theme.of(context).disabledColor)),
                        ),

                        /// DIVIDER
                        const SizedBox(height: 10),
                        const DividerCustom(),

                        /// EMAIL
                        const Padding(
                          padding: EdgeInsets.all(4),
                          child: Text('An email we can contact you',
                              style: TextStyle(color: Colors.blue)),
                        ),
                        Flexible(
                          child: TextField(
                              controller: _controllerEmail,
                              decoration:
                                  const InputDecoration(hintText: 'Email'),
                              style: TextStyle(
                                  fontSize: 24,
                                  color: Theme.of(context).disabledColor)),
                        ),

                        /// DIVIDER
                        const SizedBox(height: 10),
                        const DividerCustom(),

                        /// TODO For mobile change this to the built in widget
                        /// for web keep this one

                        /// DATE OF VISIT
                        const Padding(
                          padding: EdgeInsets.all(4.0),
                          child: Text('Select date of visit',
                              style: TextStyle(color: Colors.blue)),
                        ),
                        CustomDatePicker(),

                        /// DIVIDER
                        const SizedBox(height: 10),
                        const DividerCustom(),

                        /// BUILDINGS VISITED
                        const Padding(
                          padding: EdgeInsets.all(4),
                          child: Text('Select building(s) visited',
                              style: TextStyle(color: Colors.blue)),
                        ),
                        CustomBuildingFinder(),

                        /// DIVIDER
                        const SizedBox(height: 10),
                        const DividerCustom(),

                        /// COMMENTS
                        const Padding(
                          padding: EdgeInsets.all(4),
                          child: Text('Introduce comments (optional)',
                              style: TextStyle(color: Colors.blue)),
                        ),
                        TextField(
                          controller: _controllerComments,
                          decoration: const InputDecoration(
                            hintText: 'Anything we should know?',
                            hintStyle: TextStyle(fontSize: 24),
                          ),
                        ),

                        /// DIVIDER
                        const SizedBox(height: 20),

                        /// SUBMIT
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .buttonColor
                                  .withOpacity(0.7),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                            ),
                            child: TextButton(
                                onPressed: () async {
                                  if (context
                                          .read(buildingsAffectedSelected)
                                          .state
                                          .isNotEmpty &&
                                      AuthenticationService
                                              .validateCompleteEmail(
                                                  _controllerEmail.text) ==
                                          null &&
                                      _controllerName.text.isNotEmpty) {
                                    final List<String> buildings = context
                                        .read(buildingsAffectedSelected)
                                        .state;
                                    final comments =
                                        _controllerComments.text ?? '';
                                    final date =
                                        context.read(datePickerProvider).state;
                                    final time =
                                        context.read(timePickerProvider).state;

                                    List<ReportModel> reports =
                                        preprocessReports(
                                            _controllerName.text,
                                            _controllerEmail.text,
                                            comments,
                                            date,
                                            time,
                                            buildings);

                                    bool allReported = true;
                                    if (reports != null) {
                                      for (final ReportModel report
                                          in reports) {
                                        String statusCode = '';
                                        statusCode =
                                            await sendVisitorReport(report);
                                        if (statusCode == 'success') {
                                          continue;
                                        } else {
                                          allReported = false;
                                          await showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  title: const Text('Error'),
                                                  actions: [
                                                    const Text(
                                                        'Error sending report, try again.'),
                                                    IconButton(
                                                        icon: const Icon(
                                                            FontAwesomeIcons
                                                                .arrowLeft),
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                                context)),
                                                  ],
                                                );
                                              });
                                          break;
                                        }
                                      }
                                      if (allReported) {
                                        PageManager.of(context).addReportSent();
                                      }
                                    }
                                  } else if (context
                                      .read(buildingsAffectedSelected)
                                      .state
                                      .isEmpty) {
                                    await showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: const Text(
                                                'You have to select at least one building'),
                                            actions: [
                                              TextButton(
                                                  onPressed: () =>
                                                      Navigator.pop(context),
                                                  child: const Text('OK'))
                                            ],
                                          );
                                        });
                                  } else if (_controllerName.text.isEmpty) {
                                    await showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: const Text(
                                                'Name must not be empty'),
                                            actions: [
                                              TextButton(
                                                  onPressed: () =>
                                                      Navigator.pop(context),
                                                  child: const Text('OK'))
                                            ],
                                          );
                                        });
                                  } else {
                                    await showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title:
                                                const Text('Bad Email Format'),
                                            actions: [
                                              TextButton(
                                                  onPressed: () =>
                                                      Navigator.pop(context),
                                                  child: const Text('OK'))
                                            ],
                                          );
                                        });
                                  }
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'SUBMIT',
                                    style: Theme.of(context)
                                        .primaryTextTheme
                                        .bodyText1
                                        .copyWith(color: Colors.blue),
                                  ),
                                )),
                          ),
                        ),

                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          if (!ResponsiveWidget.isMobileScreen(context))
            Positioned(top: 10, left: 10, child: WebMenu())
        ],
      ),
    );
  }
}

class DividerCustom extends StatelessWidget {
  const DividerCustom({
    Key key,
    this.width,
  }) : super(key: key);

  final double width;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Center(
          child: Container(
        width: width ?? screenSize.width * 0.6,
        height: 2,
        color: Theme.of(context).dividerColor,
      )),
    );
  }
}
