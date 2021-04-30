import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/fcm_notification_model.dart';
import '../providers/notifications_providers.dart';

class NotificationScreen extends ConsumerWidget {
  NotificationScreen({this.notificationID});
  final String notificationID;
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final screenSize = MediaQuery.of(context).size;

    final FcmNotificationModel notification =
        watch(fcmNotificationProvider(notificationID));
    if (notification == null) {
      return const Scaffold(
          body: Center(child: Text('Ups, Notification is Empty')));
    } else {
      return Scaffold(
        appBar: AppBar(title: const Text('Notifications')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Align(
                  child: Text(notification.title ?? '',
                      style: Theme.of(context).primaryTextTheme.bodyText1)),
              Center(
                child: SingleChildScrollView(
                    child: SizedBox(
                        height: screenSize.height * 0.5,
                        child: Text(notification.body ?? '',
                            style:
                                Theme.of(context).primaryTextTheme.bodyText2))),
              ),
            ],
          ),
        ),
      );
    }
  }
}
