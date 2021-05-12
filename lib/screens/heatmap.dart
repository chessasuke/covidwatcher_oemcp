import 'package:flutter/material.dart';

import '../app_themes/responsive.dart';
import '../app_widgets/mobile_page_manager.dart';
import '../services_controller/fcm_services.dart';
import '../heatmap/heatMap.dart';

/// The first app screen displayed
/// it sets the mode (web vs mobile) according to the device width

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    /// Initializes [FCMservice] to listen for [PushNotification]s
    FcmService.initializeFCM(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget.isMobileScreen(context)
        ? MobilePageManager()
        : Center(child: Scaffold(body: Heatmap()));
  }
}
