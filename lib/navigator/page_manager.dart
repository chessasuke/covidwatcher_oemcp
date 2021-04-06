import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/home.dart';
import '../screens/settings.dart';
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
        key: const ValueKey('Home'),
        name: '/',
      ),
    ];
  }

  /// Handles updating the current path (last page)
  TheAppPath get currentPath {
    Uri uri = Uri.parse(_pages.last.name);

    /// Handle '/'
    if (uri.pathSegments.isEmpty) {
      return TheAppPath.home();
    }

    /// Handle '/settings'
    if (uri.pathSegments.length == 1) {
      if (uri.pathSegments[0] == 'settings') {
        return TheAppPath.settings();
      }
    }

    // Handle unknown routes
    return TheAppPath.unknown();
  }

  void didPop(dynamic page) {
    _pages.remove(page);
    notifyListeners();
  }

  /// This is where we handle new route information and manage the pages list
  Future<void> setNewRoutePath(TheAppPath configuration) async {
    print(configuration.isUnknownPage);
    print(configuration.isSettingsPage);

    if (configuration.isUnknownPage) {
      // Handling 404
      _pages.add(
        MaterialPage(
          child: UnknownScreen(),
          key: const ValueKey('Unknown'),
          name: '/404',
        ),
      );
    } else if (configuration.isSettingsPage) {
      // Handling details screens
      _pages.add(
        MaterialPage(
          child: SettingsScreen(),
          key: const ValueKey('Settings'),
          name: '/settings',
        ),
      );
    } else if (configuration.isHomePage) {
      // Restoring to MainScreen
      _pages.removeWhere(
        (element) => element.key != const ValueKey('Home'),
      );
    }
    notifyListeners();
    return;
  }

  void addSettings() {
    setNewRoutePath(TheAppPath.settings());
  }

  void resetToHome() {
    print('reset to home');
    setNewRoutePath(TheAppPath.home());
  }
}
