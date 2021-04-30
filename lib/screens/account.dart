import 'package:covid_watcher/app_themes/responsive.dart';
import 'package:covid_watcher/app_widgets/web_menu.dart';
import 'package:covid_watcher/user_management/logic/user_state.dart';
import 'package:covid_watcher/user_management/widgets/signin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../notifications/account_widget.dart';
import '../providers/general_providers.dart';

// ignore: use_key_in_widget_constructors
class ScreenAccount extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final screenSize = MediaQuery.of(context).size;
    final UserState currentUser = watch(userProvider.state);
    final isLoading = watch(loadingProvider).state;

    return SafeArea(
        child: Scaffold(
            body: Stack(
      children: [
        /// User is SIGNED IN
        if (currentUser is UserLoaded)
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
              child: Container(
                width: !ResponsiveWidget.isMobileScreen(context)
                    ? screenSize.width * 0.7
                    : screenSize.width,
                decoration: BoxDecoration(
                    color: Theme.of(context).buttonColor.withOpacity(
                        0.7), //                color: Color(0xEB3A60),
                    border: Border(
                      left: BorderSide(color: Theme.of(context).dividerColor),
                      right: BorderSide(color: Theme.of(context).dividerColor),
                    )),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AccountWidget(currentUser: currentUser.user),
                ),
              ),
            ),
          )
        else if (currentUser == const UserInitial())
          Align(
            child: Container(
              width: !ResponsiveWidget.isMobileScreen(context)
                  ? screenSize.width * 0.7
                  : screenSize.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text('Settings',
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
                          await showDialog(
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
                                padding: EdgeInsets.only(bottom: 16.0, top: 8),
                                child: Text(
                                    'Please sign in to manage your profile'),
                              ),
                            ],
                          ),
                        )),
                  ),
                ],
              ),
            ),
          )
        else if (currentUser == const UserLoading())
          const Center(
            child: SizedBox(
                width: 100, height: 100, child: CircularProgressIndicator()),
          )
        else
          Align(
            alignment: Alignment.center,
            child: Container(
              width: !ResponsiveWidget.isMobileScreen(context)
                  ? screenSize.width * 0.7
                  : screenSize.width,
              decoration: BoxDecoration(
                  color: Theme.of(context).buttonColor.withOpacity(
                      0.7), //                color: Color(0xEB3A60),
                  border: Border(
                    left: BorderSide(color: Theme.of(context).dividerColor),
                    right: BorderSide(color: Theme.of(context).dividerColor),
                  )),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text('Something went wrong, try again'),
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).buttonColor.withOpacity(0.7),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    child: TextButton(
                        onPressed: () async {
                          await showDialog(
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
                                padding: EdgeInsets.only(bottom: 16.0, top: 8),
                                child: Text(
                                    'Please sign in to manage your notifications'),
                              ),
                            ],
                          ),
                        )),
                  ),
                ],
              ),
            ),
          ),
        if (!ResponsiveWidget.isMobileScreen(context))
          Positioned(top: 10, left: 10, child: WebMenu()),
        if (isLoading)
          Container(
            width: screenSize.width,
            height: screenSize.height,
            color: Colors.transparent.withOpacity(0.7),
            child: const Center(child: CircularProgressIndicator()),
          )
      ],
    )));
  }
}
