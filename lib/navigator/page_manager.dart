import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../report/search_building.dart';
import '../screens/home.dart';
import '../screens/mobile_news.dart';
import '../screens/screen_report.dart';
import '../screens/screen_settings.dart';
import '../screens/sent_report_screen.dart';
import '../screens/unknown.dart';
import 'route_path.dart';

class PageManager extends ChangeNotifier {
  static PageManager of(BuildContext context) {
    return Provider.of<PageManager>(context, listen: false);
  }

  /// Here we are storing the current list of pages
  List<Page> get pages => List.unmodifiable(_pages);
  List<Page> _pages = [];
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  PageManager() {
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

    print('current path: ${uri.path}');

    /// Handle '/'
    if (uri.pathSegments.length == 1) {
      if (uri.pathSegments[0] == 'heatmap') {
        return TheAppPath.heatmap();
      }
    }

    if (uri.pathSegments.length == 1) {
      if (uri.pathSegments[0] == 'news') {
        return TheAppPath.news();
      }
    }

    if (uri.pathSegments.length == 1) {
      if (uri.pathSegments[0] == 'report') {
        return TheAppPath.selfReport();
      }
    }

    if (uri.pathSegments.length == 1) {
      if (uri.pathSegments[0] == 'settings') {
        return TheAppPath.settings();
      }
    }

    if (uri.pathSegments.length == 1) {
      if (uri.pathSegments[0] == 'report_sent') {
        return TheAppPath.isReportSent();
      }
    }

    if (uri.pathSegments.length == 1) {
      if (uri.pathSegments[0] == 'search_building') {
        return TheAppPath.searchingBuilding();
      }
    }

    // Handle unknown routes
    else {
      print('handling unknown');
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
          child: NewsTimeline(),
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
          child: ScreenSetting(),
          key: UniqueKey(),
          name: '/settings',
        ),
      );
    } else if (configuration.isSearchBuildingPage) {
      // Handling details screens
      _pages.add(
        MaterialPage(
          child: SearchBuildings(),
          key: UniqueKey(),
          name: '/search_building',
        ),
      );
    } else if (configuration.isReportSent) {
      // Handling details screens
      _pages.add(
        MaterialPage(
          child: ReportSentScreen(),
          key: UniqueKey(),
          name: '/report_sent',
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

  void addSearchingBuilding() {
    setNewRoutePath(TheAppPath.searchingBuilding());
  }

  void addReportSent() {
    setNewRoutePath(TheAppPath.isReportSent());
  }

  void resetToHome() {
    print('reset to home');
    setNewRoutePath(TheAppPath.heatmap());
  }
}
