import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'heatmap_widget.dart';

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
