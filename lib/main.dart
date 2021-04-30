import 'package:covid_watcher/providers/theme_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_custom.dart';

import 'app_themes/theme.dart';
import 'fcm/fcm_config.dart';
import 'navigator/route_parser.dart';
import 'navigator/router_delegate.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// The background messaging handler defined as a named top-level function before
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  /// Web vs Android
  if (!kIsWeb) {
    if (Platform.isAndroid) {
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);

      /// Must initialize android with a different icon name for notifications to prevent crash
      /// So go to the [res] folder and create an [ImageAsset] and give it the name that will
      /// be passed here. Make sure is in the drawable folder too
      await flutterLocalNotificationsPlugin.initialize(
          const InitializationSettings(
              android: AndroidInitializationSettings('app_icon')));
    }
  }

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  /// Initialize FIrebase
  bool _initialized = false;
  bool _error = false;

  /// Navigation 2.0
  final TheAppRouterDelegate _routerDelegate = TheAppRouterDelegate();
  final TheAppRouteInformationParser _routeInformationParser =
      TheAppRouteInformationParser();

  void initializeFlutterFire() async {
    try {
      /// Wait for Firebase to initialize and set `_initialized` state to true
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
      });
    } catch (e) {
      // Set `_error` state to true if Firebase initialization fails
      setState(() {
        _error = true;
      });
    }
  }

  @override
  void initState() {
    initializeFlutterFire();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_error) {
      return const Text('Error Initializing App');
    }

    // Show a loader until FlutterFire is initialized
    if (!_initialized) {
      return Container(
          width: 75, height: 75, child: const CircularProgressIndicator());
    }

    return ProviderScope(child: Consumer(builder: (context, watch, child) {
      final appTheme = watch(appThemeProvider);
      return MaterialApp.router(
        theme: appTheme.getTheme(),
        darkTheme: AppDynamicTheme.darkTheme,
        themeMode: AppDynamicTheme.isDark ? ThemeMode.dark : ThemeMode.light,
        debugShowCheckedModeBanner: false,
        title: 'Covid Watcher',
        routerDelegate: _routerDelegate,
        routeInformationParser: _routeInformationParser,
      );
    }));
  }
}
