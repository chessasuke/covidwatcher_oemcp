import 'package:flutter/material.dart';
import 'route_path.dart';

///
/// Two important classes in Navigation 2.0 - RouteInformationParser and RouterDelegate
/// The RouteInformationParser have two important functions
/// - converts the configuration (navigation state) into a RouteInformation (uri)
/// using the parseRouteInformation function.
/// - converts the RouteInformation (uri) into a configuration (navigation state)
/// using the parseRoute
///
/// When the engine pushes a new route, the route information is parsed by the
/// RouteInformationParser to produce a configuration of type T.
///

class TheAppRouteInformationParser extends RouteInformationParser<TheAppPath> {
  /// call when there is a change to the URL in the browser
  /// converts the url into a navigation state
  @override
  Future<TheAppPath> parseRouteInformation(
      RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location);

    if (uri.pathSegments.length == 0) {
      return TheAppPath.heatmap();
    } else if (uri.pathSegments.length != 1) {
      return TheAppPath.unknown();
    } else {
      if (uri.pathSegments[0] == 'heatmap') {
        return TheAppPath.heatmap();
      } else if (uri.pathSegments[0] == 'news') {
        return TheAppPath.news();
      } else if (uri.pathSegments[0] == 'report') {
        return TheAppPath.selfReport();
      } else if (uri.pathSegments[0] == 'settings') {
        return TheAppPath.settings();
      } else if (uri.pathSegments[0] == 'search_building') {
        return TheAppPath.searchingBuilding();
      }
//      else if (uri.pathSegments[0] == 'signin') {
//        return TheAppPath.signIn();
//      }
      else {
        return TheAppPath.unknown();
      }
    }
  }

  @override
  RouteInformation restoreRouteInformation(TheAppPath path) {
    if (path.isHeatmapPage) {
      return const RouteInformation(location: '/heatmap');
    }

    if (path.isNewsPage) {
      return const RouteInformation(location: '/news');
    }

    if (path.isReportPage) {
      return const RouteInformation(location: '/report');
    }

    if (path.isSettingsPage) {
      return const RouteInformation(location: '/settings');
    }

//    if (path.isSignIn) {
//      return const RouteInformation(location: '/signin');
//    }

    if (path.isSearchBuildingPage) {
      return const RouteInformation(location: '/search_building');
    }

    return const RouteInformation(location: '/unknown');
  }
}
