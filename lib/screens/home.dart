import 'package:flutter/material.dart';
import '../map/heatMap.dart';
import '../screens_mobile/mobile_page_manager.dart';
import '../theme/responsive.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget.isMobileScreen(context)
        ? MobilePageManager()
        : Center(child: Scaffold(body: Heatmap()));
  }
}
