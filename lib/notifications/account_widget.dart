import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/user_model.dart';
import '../services_controller/firebase_auth_services.dart';
import 'fcm_notifications/fcm_notifications_btn.dart';
import 'subscribed_building_wigets/manage_favorites_btn.dart';

/// NOTIFICATION WIDGET, this goes directly in screen settings

class SettingsWidget extends StatelessWidget {
  const SettingsWidget({@required this.currentUser});
  final UserModel currentUser;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Container(
        height: screenSize.height * 0.9,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              'Hello ${currentUser.getName}!',
              style: const TextStyle(fontSize: 24),
            ),
            SizedBox(
              child: Column(
                children: [
                  SubscribedBuildingBtn(),
                  FcmNotificationsBtn(),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const SizedBox(),
                Flexible(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).buttonColor.withOpacity(0.7),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
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
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(),
                Flexible(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).buttonColor.withOpacity(0.7),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: TextButton(
                        onPressed: () async {
                          String statusCode = '';
                          await showDialog(
                              context: (context),
                              builder: (context) {
                                final TextEditingController _controller =
                                    TextEditingController();
                                return SimpleDialog(
                                  title: Text(
                                      'Do you want to delete your account?'),
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          TextButton(
                                              onPressed: () =>
                                                  Navigator.pop(context, true),
                                              child: const Text('Yes')),
                                          TextButton(
                                              onPressed: () =>
                                                  Navigator.pop(context, false),
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
                                builder: (context) => const AlertDialog(
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
    );
  }
}
