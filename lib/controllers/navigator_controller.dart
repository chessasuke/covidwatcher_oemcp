import 'package:covid_watcher/screens/notification_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../navigator/route_path.dart';
import '../screens/heatmap.dart';
import '../screens/news.dart';
import '../screens/self_report.dart';
import '../screens/account.dart';
import '../screens/unknown.dart';

/// Controls the app navigation states and flow
/// This is the class in charge of going from one screen to another one
/// also controls inputs from the url bar in the web mode
/// It's connected with the other support class of the navigation module

class NavigatorController extends ChangeNotifier {
  static NavigatorController of(BuildContext context) {
    return Provider.of<NavigatorController>(context, listen: false);
  }

  /// Here we are storing the current list of pages
  List<Page> get pages => List.unmodifiable(_pages);
  List<Page> _pages = [];
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  NavigatorController() {
    _pages = [
      MaterialPage(
        child: HomeScreen(),
        key: const ValueKey('Heatmap'),
        name: '/heatmap',
      ),
    ];
  }

  /// Figures out which is the current path (last page)
  TheAppPath get currentPath {
    Uri uri = Uri.parse(_pages.last.name);

    /// Handle '/'
    if (uri.pathSegments.length == 1) {
      if (uri.pathSegments[0] == 'heatmap') {
        return TheAppPath.heatmap();
      }
    } else if (uri.pathSegments.length == 1) {
      if (uri.pathSegments[0] == 'news') {
        return TheAppPath.news();
      }
    } else if (uri.pathSegments.length == 1) {
      if (uri.pathSegments[0] == 'report') {
        return TheAppPath.selfReport();
      }
    } else if (uri.pathSegments.length == 1) {
      if (uri.pathSegments[0] == 'settings') {
        return TheAppPath.settings();
      }
    } else if (uri.pathSegments.length == 2) {
      if (uri.pathSegments[0] != 'notification') {
        return TheAppPath.unknown();
      } else {
        String remaining = uri.pathSegments[1];
        return TheAppPath.notification(id: remaining);
      }
    } else {
      return TheAppPath.unknown();
    }
  }

  void didPop(dynamic page) {
    _pages.remove(page);
    notifyListeners();
  }

  /// This is where we handle new route information and manage the pages list
  Future<void> setNewRoutePath(TheAppPath configuration) async {
    if (configuration.isUnknownPage) {
      _pages.add(
        MaterialPage(
          child: UnknownScreen(),

          /// ****THIS MUST BE UNIQUE KEY
          key: UniqueKey(),
          name: '/404',
        ),
      );
    } else if (configuration.isNewsPage) {
      // Handling details screens
      _pages.add(
        MaterialPage(
          child: News(),
          key: UniqueKey(),
          name: '/news',
        ),
      );
    } else if (configuration.isReportPage) {
      // Handling details screens
      _pages.add(
        MaterialPage(
          child: ScreenReport(),
          key: UniqueKey(),
          name: '/report',
        ),
      );
    } else if (configuration.isSettingsPage) {
      // Handling details screens
      _pages.add(
        MaterialPage(
          child: ScreenAccount(),
          key: UniqueKey(),
          name: '/settings',
        ),
      );
    } else if (configuration.isNotificationPage) {
      _pages.add(
        MaterialPage(
          /// Send the id of the notification, then can be retrieve from a provider list using the id
          child: NotificationScreen(notificationID: configuration.id),
          key: UniqueKey(),
          name: '/notification',
        ),
      );
    } else if (configuration.isHeatmapPage) {
      // Restoring to MainScreen
      _pages.removeWhere(
        (element) => element.key != const ValueKey('Heatmap'),
      );
    }
    notifyListeners();
    return;
  }

  void addSettings() {
    setNewRoutePath(TheAppPath.settings());
  }

  void addNews() {
    setNewRoutePath(TheAppPath.news());
  }

  void addReport() {
    setNewRoutePath(TheAppPath.selfReport());
  }

  void addNotificationScreen(String notificationID) {
    setNewRoutePath(TheAppPath.notification(id: notificationID));
  }

  void resetToHome() {
    print('reset to home');
    setNewRoutePath(TheAppPath.heatmap());
  }
}
