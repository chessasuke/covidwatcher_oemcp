import 'dart:ui';

import 'package:covid_watcher/animation.dart';
import 'package:covid_watcher/map/web_menu.dart';
import 'package:covid_watcher/report/building_finder.dart';
import 'package:covid_watcher/report/calendar_picker.dart';
import 'package:covid_watcher/theme/responsive.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ReportForm extends StatefulWidget {
  @override
  _ReportFormState createState() => _ReportFormState();
}

class _ReportFormState extends State<ReportForm> {
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Center(
      child: Container(
        width: !ResponsiveWidget.isMobileScreen(context)
            ? screenSize.width * 0.7
            : screenSize.width,
        height: screenSize.height,
        decoration: BoxDecoration(
            color: Theme.of(context)
                .buttonColor
                .withOpacity(0.7), //                color: Color(0xEB3A60),
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
                    constraints: BoxConstraints(maxHeight: 250),
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
                      ],
                    ),
                  ),
                ),

                /// DIVIDER
                DividerCustom(),

                /// NAME + EMAIL
                if (!ResponsiveWidget.isMobileScreen(context))
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Flexible(
                        child: Text('Name Here',
                            style: TextStyle(
                                fontSize: 24,
                                color: Theme.of(context).disabledColor)),
                      ),
                      const Flexible(
                          child: Text('Email Here',
                              style: const TextStyle(fontSize: 24))),
                    ],
                  )
                else
                  Column(
                    children: [
                      Text('Name Here',
                          style: TextStyle(
                              fontSize: 24,
                              color: Theme.of(context).disabledColor)),
                      const SizedBox(height: 10),
                      Text('Email Here', style: const TextStyle(fontSize: 24)),
                    ],
                  ),

                /// DIVIDER
                const SizedBox(height: 10),
                DividerCustom(),

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
                  controller: _controller,
                  decoration: const InputDecoration(
                    hintText: 'Anything we should know?',
                    hintStyle: TextStyle(fontSize: 24),
                  ),
                ),

                /// DIVIDER
                const SizedBox(height: 10),
                const DividerCustom(),

                /// SUBMIT
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton(
                      onPressed: () {},
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

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
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
