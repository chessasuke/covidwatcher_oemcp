import 'package:flutter/material.dart';

import '../heatmap/heatMap.dart';
import '../theme/responsive.dart';
import 'mobile_page_manager.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget.isMobileScreen(context)
        ? MobilePageManager()
        : Center(child: Scaffold(body: Heatmap()));
  }
}
