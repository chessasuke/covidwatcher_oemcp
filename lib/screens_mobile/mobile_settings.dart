import 'package:covid_watcher/map/web_menu.dart';
import 'package:covid_watcher/models/user_state.dart';
import 'package:covid_watcher/navigator/page_manager.dart';
import 'package:covid_watcher/theme/responsive.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../auth/signin.dart';
import '../service/firebase_services.dart';

// ignore: use_key_in_widget_constructors
class ScreenSetting extends StatefulWidget {
  @override
  _ScreenSettingState createState() => _ScreenSettingState();
}

class _ScreenSettingState extends State<ScreenSetting> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(body: Consumer(builder: (context, watch, build) {
      final UserState currentUser = watch(userProvider).state;
      print('currentUser: $currentUser');
      return Stack(
        children: [
          if (currentUser != const UserInitial() &&
              currentUser != const UserLoading() &&
              currentUser != const UserError())
            Align(
              alignment: Alignment.center,
              child: TextButton(
                  onPressed: () async {
                    await context.read(authServiceProvider).signOut();
                  },
                  child: Text(
                    'Sign out',
                    style: Theme.of(context)
                        .primaryTextTheme
                        .bodyText1
                        .copyWith(color: Colors.blue),
                  )),
            )
          else
            Align(
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
                                    'Please sign in to manage your profile'),
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
    })));

//      Column(
//              mainAxisAlignment: MainAxisAlignment.start,
//              children: [
//                Row(
//                  mainAxisAlignment: MainAxisAlignment.spaceAround,
//                  children: [
//                    //todo uncomment here
//                    Text(currentUser.getName != null
//                        ? 'Hello ${currentUser.getName}!'
//                        : 'Hello'),
//                    ToggleBrightness(),
//                  ],
//                ),
//                Card(
//                  elevation: 30,
//                  child: ListTile(
//                    leading: Text('Profile',
//                        style: Theme.of(context).primaryTextTheme.bodyText1),
//                    trailing: const Icon(FontAwesomeIcons.user),
//                  ),
//                ),
//                Card(
//                  elevation: 30,
//                  child: ListTile(
//                    leading: Text('Manage Notifications',
//                        style: Theme.of(context).primaryTextTheme.bodyText1),
//                    trailing: const Icon(FontAwesomeIcons.bell),
//                  ),
//                ),
//                Card(
//                  elevation: 30,
//                  child: ListTile(
//                    leading: Text('Help & Support',
//                        style: Theme.of(context).primaryTextTheme.bodyText1),
//                    trailing: const Icon(FontAwesomeIcons.solidQuestionCircle),
//                  ),
//                ),
//                Card(
//                  elevation: 30,
//                  child: ListTile(
//                    leading: Text('About Us',
//                        style: Theme.of(context).primaryTextTheme.bodyText1),
//                    trailing: const Icon(FontAwesomeIcons.users),
//                  ),
//                ),
//                Spacer(),
//                Flexible(
//                  child: Container(
//                    width: 200,
//                    decoration: BoxDecoration(
//                        borderRadius: BorderRadius.all(Radius.circular(10)),
//                        color: Theme.of(context).buttonColor),
//                    child: TextButton(
//                        onPressed: () async {
//                          print('logout');
////                          await AuthenticationService.signOut();
//                        },
//                        child: Text('Log out',
//                            style:
//                                Theme.of(context).primaryTextTheme.bodyText1)),
//                  ),
//                ),
//                SizedBox(height: 10),
//                Flexible(
//                  child: Container(
//                    width: 200,
//                    decoration: const BoxDecoration(
//                      color: Colors.red,
//                      borderRadius: BorderRadius.all(Radius.circular(10)),
//                    ),
//                    child: TextButton(
//                        onPressed: () {
//                          print('delete account');
////                          AuthenticationService.deleteAccount(
////                              currentUser.getUid);
//                        },
//                        child: Text('Delete Account',
//                            style:
//                                Theme.of(context).primaryTextTheme.bodyText1)),
//                  ),
//                ),
//                const SizedBox(height: 10),
//              ],
//            )
//          : Column(
//              mainAxisAlignment: MainAxisAlignment.spaceBetween,
//              children: [
//                Center(
//                    child: TextButton(
//                        onPressed: () {
//                          showDialog(
//                              context: context,
//                              builder: (context) {
//                                return const SignIn();
//                              });
//                        },
//                        child: Text(
//                          'Sign in',
//                          style: Theme.of(context)
//                              .primaryTextTheme
//                              .bodyText1
//                              .copyWith(color: Colors.blue),
//                        ))),
//                TextButton(
//                  child: Text('initialize'),
//                  onPressed: () async {
//                    context.read(userProvider).getUid;
////                    await UserModel.initializeFields();
//                  },
//                ),
//                const SizedBox(width: 50),
//              ],
//            ),
//    );
  }
}
