import 'package:covid_watcher/models/building_event_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// THIS FILE CONTAINS PROVIDERS CONNECTED TO THE HEATMAP MODULE

/// manages state of the list containing the covid events (covid cases)
final eventRepositoryProvider = StateProvider<List<EventModel>>((ref) {
  List<EventModel> events = [];
  return events;
});

/// provides the state of the date filter
final filterDateProvider = StateProvider<String>((ref) => 'Last Month');

/// provides the state of the rate filter
final filterRateProvider = StateProvider<String>((ref) => '+0');

/// provides the state of showBuildings
final showBuildingMarkerProvider = StateProvider<bool>((ref) => false);

/// provides the state of showStructures
final showStructureMarkerProvider = StateProvider<bool>((ref) => false);

/// provides the state of searchBar
final showSearchBarProvider = StateProvider<bool>((ref) => false);

/// provides the state of the rate filter
final filterNameProvider = StateProvider<String>((ref) => '');

/// provides the state showBookmarked
final showBookmarkedProvider = StateProvider<bool>((ref) => false);

/// handle states of the bookmarked buildings list
final bookmarkedBuidlingsProvider =
    FutureProvider.autoDispose<List<String>>((ref) async {
  /// get notifier buildings from shared preferences
  final prefs = await SharedPreferences.getInstance();
  List<String> favBuilds = prefs.getStringList('sub');

  /// To avoid call shared preferences unnecessary everytime
  ref.maintainState = true;
  if (favBuilds == null || favBuilds.isEmpty) {
    favBuilds = [];
  }
  print('favBuilds: ${favBuilds.length}');
  return favBuilds;
});
