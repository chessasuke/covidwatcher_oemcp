import 'package:covid_watcher/map/heatmap_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Buildings selected when user open the search page
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

class Heatmap extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final bookmarkedBuildings = watch(bookmarkedBuidlingsProvider);

    /// -----------------------------------------------------
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.black,
        body: bookmarkedBuildings.when(
            data: (data) {
              List<String> favs = data;
              return HeatmapWidget(favs: favs);
            },
            loading: () => const CircularProgressIndicator(),
            error: (error, _) {
              return Text('Error: $error');
            }));
  }
}
