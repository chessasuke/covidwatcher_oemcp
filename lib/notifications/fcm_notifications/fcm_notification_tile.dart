import 'package:covid_watcher/models/fcm_notification_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

/// Widget tiles that appear in the manage notification section with
/// the Buildings for which we are subscribed to receive notifications
/// has a function to quickly remove the corresponding building

typedef RemoveItem = void Function();
typedef ViewItem = void Function(String);

class FcmNotificationTile extends StatelessWidget {
  const FcmNotificationTile(
      {this.notification, this.deleteCallback, this.viewCallback});
  final FcmNotificationModel notification;
  final RemoveItem deleteCallback;
  final ViewItem viewCallback;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Container(
        width: screenSize.width,
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).disabledColor),
        ),
        child: Padding(
          padding: const EdgeInsets.all(3),

          /// TODO overflow
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: InkWell(
                  onTap: () => viewCallback(notification.id),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(notification.title ?? '',
                          overflow: TextOverflow.ellipsis),
                      Text(notification.time == null
                          ? ''
                          : DateFormat("MM-dd  HH:mm:ss")
                              .format(DateTime.parse(notification.time))
                              .toString()),
                    ],
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(FontAwesomeIcons.solidTrashAlt),
                onPressed: deleteCallback,
              ),
            ],
          ),
        ));
  }
}
