import 'package:covid_watcher/controllers/navigator_controller.dart';
import 'package:flutter/material.dart';

/// Item for the web menu at the top-left of the screen in web mode

class WebMenuItem extends StatefulWidget {
  const WebMenuItem({this.menuName, Key key}) : super(key: key);
  final String menuName;

  @override
  _WebMenuItemState createState() => _WebMenuItemState();
}

class _WebMenuItemState extends State<WebMenuItem> {
  double menuWidth = 0;

  @override
  Widget build(BuildContext context) {
    Size size = (TextPainter(
            text: TextSpan(text: widget.menuName),
            maxLines: 1,
            textScaleFactor: MediaQuery.of(context).textScaleFactor,
            textDirection: TextDirection.ltr)
          ..layout())
        .size;

    return GestureDetector(
      onTap: () {
        if (widget.menuName == 'Heatmap') {
          NavigatorController.of(context).resetToHome();
        } else if (widget.menuName == 'News') {
          NavigatorController.of(context).addNews();
        } else if (widget.menuName == 'Self-Report') {
          NavigatorController.of(context).addReport();
        } else if (widget.menuName == 'Settings') {
          NavigatorController.of(context).addSettings();
        }
      },
      child: MouseRegion(
        onEnter: (onEnter) => setState(() => menuWidth = size.width),
        onExit: (onExit) => setState(() => menuWidth = 0),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            children: [
              Text(widget.menuName),
              AnimatedContainer(
                  curve: Curves.easeOut,
                  color: Colors.white,
                  height: 1,
                  width: menuWidth,
                  duration: const Duration(milliseconds: 300))
            ],
          ),
        ),
      ),
    );
  }
}
