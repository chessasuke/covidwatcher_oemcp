import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'navigator/route_parser.dart';
import 'navigator/router_delegate.dart';
import 'theme/theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
      // Wait for Firebase to initialize and set `_initialized` state to true
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
