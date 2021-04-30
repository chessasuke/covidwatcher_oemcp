import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../app_themes/responsive.dart';
import '../app_widgets/custom_animation.dart';
import '../constants.dart';
import '../user_management/logic/auth_logic.dart';

class ReportFormOEMCP extends StatelessWidget {
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
          child: Column(
            mainAxisSize: MainAxisSize.min,
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
                            child: const CustomAnimation()),
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
              const SizedBox(height: 10),
              const DividerCustom(),

              Container(
                constraints: BoxConstraints(maxHeight: screenSize.height - 230),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      /// COVID REPORT
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color:
                                Theme.of(context).buttonColor.withOpacity(0.7),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                          ),
                          child: TextButton(
                              onPressed: () {
                                AuthenticationService.launchURL(
                                    OEMCP_SELF_REPORT_URL);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        'UTD SELF-REPORT FORM',
                                        style: Theme.of(context)
                                            .primaryTextTheme
                                            .bodyText1
                                            .copyWith(color: Colors.blue),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    const Flexible(
                                        child: Icon(
                                            FontAwesomeIcons.externalLinkAlt))
                                  ],
                                ),
                              )),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color:
                                Theme.of(context).buttonColor.withOpacity(0.7),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                          ),
                          child: TextButton(
                              onPressed: () {
                                AuthenticationService.launchURL(
                                    OEMCP_VACCINE_REPORT_URL);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        'UTD VACCINE REPORT FORM',
                                        style: Theme.of(context)
                                            .primaryTextTheme
                                            .bodyText1
                                            .copyWith(color: Colors.blue),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    const Flexible(
                                        child: Icon(
                                            FontAwesomeIcons.externalLinkAlt)),
                                  ],
                                ),
                              )),
                        ),
                      ),

                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color:
                                Theme.of(context).buttonColor.withOpacity(0.7),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextButton(
                              onPressed: () {
                                if (!kIsWeb) {
                                  AuthenticationService.launchEmailSubmission(
                                      visitorReportEmail,
                                      reportEmailSubject,
                                      reportEmailBody);
                                }
                              },
                              child: Column(
                                children: [
                                  const Text(
                                      'If you are a visitor self-report by email'),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Flexible(
                                          child: Text(
                                        visitorReportEmail,
                                        style: Theme.of(context)
                                            .primaryTextTheme
                                            .bodyText1
                                            .copyWith(color: Colors.blue),
                                      )),
                                      const SizedBox(width: 10),
                                      const Flexible(
                                          child: Icon(
                                              FontAwesomeIcons.solidEnvelope)),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
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
