import 'package:covid_watcher/providers/loading_provider.dart';

import '../notifications/manage_notification_btn.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../auth/signin.dart';
import '../map/web_menu.dart';
import '../models/user_state.dart';
import '../service/firebase_services.dart';
import '../theme/responsive.dart';

// ignore: use_key_in_widget_constructors
class ScreenSetting extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final screenSize = MediaQuery.of(context).size;
    final UserState currentUser = watch(userProvider.state);
    final isLoading = watch(loadingProvider).state;

    print('currentUser: ${currentUser.runtimeType}');
    return SafeArea(
        child: Scaffold(
            body: Stack(
      children: [
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'Hello ${currentUser.user.getName}!',
                        style: const TextStyle(fontSize: 24),
                      ),
                      ManageNotficationBtn(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const SizedBox(),
                          Flexible(
                            child: Container(
//                              constraints: const BoxConstraints(maxWidth: 150),
                              decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .buttonColor
                                    .withOpacity(0.7),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: TextButton(
                                  onPressed: () async {
                                    await context
                                        .read(authServiceProvider)
                                        .signOut();
                                  },
                                  child: Text(
                                    'Sign out',
                                    style: Theme.of(context)
                                        .primaryTextTheme
                                        .bodyText1
                                        .copyWith(color: Colors.blue),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(),
                          Flexible(
                            child: Container(
//                              constraints: const BoxConstraints(maxWidth: 150),
                              decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .buttonColor
                                    .withOpacity(0.7),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: TextButton(
                                  onPressed: () async {
                                    String statusCode = '';
                                    await showDialog(
                                        context: (context),
                                        builder: (context) {
                                          final TextEditingController
                                              _controller =
                                              TextEditingController();
                                          return SimpleDialog(
                                            title: Text(
                                                'Do you want to delete your account?'),
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  children: [
                                                    TextButton(
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                                context, true),
                                                        child:
                                                            const Text('Yes')),
                                                    TextButton(
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                                context, false),
                                                        child: const Text('No'))
                                                  ],
                                                ),
                                              )
                                            ],
                                          );
                                        }).then((value) async {
//                                      if (value == true) {
//                                        print('delete account');
//                                        statusCode = await context
//                                            .read(authServiceProvider)
//                                            .deleteAccount(
//                                                currentUser.user.getUid);
//                                      }
                                      await showDialog(
                                          context: context,
                                          builder: (context) =>
                                              const AlertDialog(
                                                title: Text(
                                                    'Error while deleting account - TODO note: Sensible operation  must implement reauthentication'),
                                              ));
                                    });
                                  },
                                  child: Text(
                                    'Delete Account',
                                    style: Theme.of(context)
                                        .primaryTextTheme
                                        .bodyText1
                                        .copyWith(color: Colors.redAccent),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(),
                        ],
                      ),
                    ],
                  ),
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
                                    'Please sign in to manage your profile'),
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
