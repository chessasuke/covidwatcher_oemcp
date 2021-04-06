import 'page_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'route_path.dart';

///
/// Two important classes in Navigation 2.0 - RouteInformationParser and RouterDelegate
///
/// The RouterDelegate responds to push route and pop route actions from the engine and notifies
/// the [Router] to rebuild. It's use by Router widget to build and configure a navigating widget.
/// The router delegate receives the configuration through setInitialRoutePath or setNewRoutePath
/// to configure itself and builds the latest navigating widget when asked (build).
///
/// In this example we are using pageManager to further organize out code and have more flexibility

class TheAppRouterDelegate extends RouterDelegate<TheAppPath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<TheAppPath> {
  TheAppRouterDelegate() {
    // This part is important because we pass the notification
    // from RoutePageManager to RouterDelegate. This way our navigation
    // changes (e.g. pushes) will be reflected in the address bar
    pageManager.addListener(notifyListeners);
  }
  final PageManager pageManager = PageManager();

  /// In the build method we need to return Navigator using [navigatorKey]
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PageManager>.value(
      value: pageManager,
      child: Consumer<PageManager>(
        builder: (context, pageManager, child) {
          return Navigator(
            key: navigatorKey,
            onPopPage: _onPopPage,
            pages: List.of(pageManager.pages),
          );
        },
      ),
    );
  }

  bool _onPopPage(Route<dynamic> route, dynamic result) {
    final didPop = route.didPop(result);
    if (!didPop) {
      return false;
    }

    /// Notify the PageManager that page was popped
    pageManager.didPop(route.settings);
    return true;
  }

  @override
  GlobalKey<NavigatorState> get navigatorKey => pageManager.navigatorKey;

  @override
  TheAppPath get currentConfiguration => pageManager.currentPath;

  @override
  Future<void> setNewRoutePath(TheAppPath configuration) async {
    await pageManager.setNewRoutePath(configuration);
  }
}
