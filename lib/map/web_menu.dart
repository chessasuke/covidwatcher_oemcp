import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import 'web_menu_item.dart';

class WebMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.7),
      child: Row(
        children: menu
            .map((e) => WebMenuItem(
                  menuName: e,
                  key: UniqueKey(),
                ))
            .toList(),
      ),
    );
  }
}
