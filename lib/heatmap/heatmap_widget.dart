import 'package:covid_watcher/app_themes/responsive.dart';
import 'package:covid_watcher/app_widgets/web_menu.dart';
import 'package:covid_watcher/controllers/heatmap_controller.dart';
import 'package:covid_watcher/heatmap/widgets/custom_searchbar.dart';
import 'package:covid_watcher/heatmap/widgets/dropdown_rate_filter.dart';
import 'package:covid_watcher/heatmap/widgets/info_dialog.dart';
import 'package:covid_watcher/providers/heatmap_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'widgets/dropdown_date_filter.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:covid_watcher/controllers/affected_buildings.dart';
import '../providers/structures_provider.dart';

/// The actual heatmap widget

class HeatmapWidget extends ConsumerWidget {
  HeatmapWidget({this.favs});
  final List<String> favs;

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final showBuildingMarker = watch(showBuildingMarkerProvider).state;
    final showStructureMarker = watch(showStructureMarkerProvider).state;
    final showSearchBar = watch(showSearchBarProvider).state;
    final showBookmarked = watch(showBookmarkedProvider).state;

    final buildings = watch(buildingProvider);
    final affectedBuildings = watch(affectedBuildingsProvider).state;

    final structures4d = watch(structure4dProvider);
    final streets = watch(streetsProvider);

    final Size screenSize = MediaQuery.of(context).size;

    return Stack(children: [
      InteractiveViewer(
        maxScale: 3.5,
        minScale: 1,
        child: Stack(

            /// Call heatmap controller to render the map
            children: HeatmapController.buildMap(
          screenSize,
          showBuildingMarker,
          showStructureMarker,
          showSearchBar,
          showBookmarked,
          buildings,
          structures4d,
          streets,
          affectedBuildings,
          favs,
        )),
      ),
      if (showSearchBar)
        CustomSearchBar(callback: (String value) {
          context.read(filterNameProvider).state = value;
        }),
      Positioned(
          top: screenSize.height / 2 - 58,
          left: 20,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              border: Border.all(color: Colors.white),
              color: Colors.black.withOpacity(0.8),
            ),
            child: Column(
              children: [
                IconButton(
                    icon: Icon(
                      FontAwesomeIcons.search,
                      color: showSearchBar
                          ? Theme.of(context).accentColor
                          : Colors.white,
                    ),
                    onPressed: () {
                      context.read(showSearchBarProvider).state =
                          !context.read(showSearchBarProvider).state;
                    }),
                IconButton(
                    icon: Icon(
                      FontAwesomeIcons.bookmark,
                      color: showBookmarked
                          ? Theme.of(context).accentColor
                          : Colors.white,
                    ),
                    onPressed: () {
                      context.read(showBookmarkedProvider).state =
                          !context.read(showBookmarkedProvider).state;
                    }),
                IconButton(
                    icon: const Icon(
                      FontAwesomeIcons.filter,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return Container(
                              constraints: const BoxConstraints(
                                  maxWidth: 300, maxHeight: 300),
                              child: SimpleDialog(
                                  backgroundColor:
                                      Theme.of(context).dialogBackgroundColor,
                                  elevation: 30,
                                  title: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: const [
                                      Flexible(
                                          child: Icon(FontAwesomeIcons.filter)),
                                      SizedBox(width: 20),
                                      Flexible(child: Text('Filters')),
                                    ],
                                  ),
                                  children: [
                                    SizedBox(height: 10),
                                    DropdownDateFilter(),
                                    DropdownRateFilter(),
                                  ]),
                            );
                          });
                    }),
                IconButton(
                    icon: Icon(
                      FontAwesomeIcons.solidBuilding,
                      color: showBuildingMarker
                          ? Theme.of(context).accentColor
                          : Colors.white,
                    ),
                    onPressed: () {
                      context.read(showBuildingMarkerProvider).state =
                          !context.read(showBuildingMarkerProvider).state;
                    }),
                IconButton(
                    icon: Icon(FontAwesomeIcons.mapMarkerAlt,
                        color: showStructureMarker
                            ? Theme.of(context).accentColor
                            : Colors.white),
                    onPressed: () {
                      context.read(showStructureMarkerProvider).state =
                          !context.read(showStructureMarkerProvider).state;
                    }),
                IconButton(
                    icon: const Icon(FontAwesomeIcons.replyAll,
                        color: Colors.white),
                    onPressed: () {
                      context.read(showStructureMarkerProvider).state = false;
                      context.read(showSearchBarProvider).state = false;
                      context.read(showBuildingMarkerProvider).state = false;
                      context.read(filterNameProvider).state = '';
                      context.read(filterDateProvider).state = 'Last Month';
                      context.read(filterRateProvider).state = '+0';
                      context.read(showBookmarkedProvider).state = false;
                    }),
                IconButton(
                    icon: const Icon(FontAwesomeIcons.infoCircle,
                        color: Colors.white),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return InfoDialog();
                          });
                    }),
              ],
            ),
          )),
      if (!ResponsiveWidget.isMobileScreen(context))
        Positioned(top: 10, left: 10, child: WebMenu()),
    ]);
  }
}
