import 'package:covid_watcher/models/user_model.dart';
import 'package:covid_watcher/models/user_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../auth/signin.dart';
import '../service/firebase_services.dart';
import '../theme/theme_toggle.dart';

// ignore: use_key_in_widget_constructors
class MobileSettings extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
//    final authProvider = watch(authServiceProvider);
    final currentUser = watch(userProvider).state;
    print('currentUser in mobile settings: $currentUser');

    return SafeArea(
      child: currentUser != const UserInitial()
          ? TextButton(
              onPressed: () async {
                await context.read(authServiceProvider).signOut();
              },
              child: Text(
                'Sign out',
                style: Theme.of(context)
                    .primaryTextTheme
                    .bodyText1
                    .copyWith(color: Colors.blue),
              ))
          : TextButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return const SignIn();
                    });
              },
              child: Text(
                'Sign in',
                style: Theme.of(context)
                    .primaryTextTheme
                    .bodyText1
                    .copyWith(color: Colors.blue),
              )),
    );

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
