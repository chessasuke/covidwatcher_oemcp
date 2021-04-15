import 'package:flutter/material.dart';

import '../map/heatMap.dart';
import '../theme/responsive.dart';
import 'mobile_page_manager.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget.isMobileScreen(context)
        ? MobilePageManager()
        : Center(child: Scaffold(body: Heatmap()));
  }
}
