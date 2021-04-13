import 'dart:math';

import 'package:covid_watcher/map/web_menu.dart';
import 'package:covid_watcher/theme/responsive.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../auth/auth_logic.dart';
import '../constants.dart';
import '../controllers/news_controller.dart';
import '../models/news_model.dart';
import '../theme/adabtableFontSize.dart';

class NewsTimeline extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final NewsController dataController = watch(newsProvider);
//    print(dataController.getList.length);
    final screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
//        appBar: CustomAppBar(),
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
//            Container(
//              constraints: BoxConstraints(
//                maxHeight: screenSize.height,
//                maxWidth: screenSize.width,
//              ),
//              decoration: const BoxDecoration(
//                gradient: LinearGradient(
//                  begin: Alignment.topLeft,
//                  end: Alignment.bottomRight,
//                  colors: [
//                    Colors.white70,
//                    Colors.grey,
//                  ],
//                ),
//              ),
//              child: Center(
//                child: RefreshIndicator(
//                  onRefresh: () async {
////                    await context.read(newsProvider).updateList();
//                  },
//                  child: Column(
//                    children: <Widget>[
//                      Expanded(
//                        child: CustomScrollView(
//                          slivers: <Widget>[
//                            SliverAppBar(
////                              leading: Center(
////                                child: Padding(
////                                  padding: const EdgeInsets.only(left: 6.0),
////                                  child: Text('Quick Links',
////                                      style: Theme.of(context)
////                                          .primaryTextTheme
////                                          .bodyText2
////                                          .copyWith(
////                                              color: Colors.blue,
////                                              fontSize:
////                                                  FlexFontSize.getFontSize(
////                                                          context)
////                                                      .bodyText2
////                                                      .fontSize)),
////                                ),
////                              ),
//                              actions: [
//                                Container(
//                                    constraints: BoxConstraints(
//                                        maxWidth: screenSize.width * 0.6),
//                                    child: _Header())
//                              ],
//                              floating: true,
//                              shadowColor: Colors.black,
//                              backgroundColor: Colors.transparent,
//                            ),
//                            if ((dataController.getList != null) &&
//                                (dataController.getList.isNotEmpty))
//                              _Timeline(data: dataController.getList)
//                            else
//                              SliverFillRemaining(
//                                child: Container(
//                                    decoration: const BoxDecoration(
//                                      gradient: LinearGradient(
//                                        begin: Alignment.topLeft,
//                                        end: Alignment.bottomRight,
//                                        colors: [
//                                          Colors.white54,
//                                          Colors.white,
//                                        ],
//                                      ),
//                                    ),
//                                    child: Center(
//                                        child: Container(
//                                            width: 100,
//                                            height: 100,
//                                            child:
//                                                CircularProgressIndicator()))),
//                              ),
//                          ],
//                        ),
//                      ),
//                      const SizedBox(height: 8),
//                    ],
//                  ),
//                ),
//              ),
//            ),
            if (!ResponsiveWidget.isMobileScreen(context))
              Positioned(top: 10, left: 10, child: WebMenu()),
          ],
        ),
      ),
    );
  }
}

class _Timeline extends StatelessWidget {
  const _Timeline({Key key, this.data}) : super(key: key);

  final List<NewsModel> data;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          final int itemIndex = index ~/ 2;
          final NewsModel itemData = data[itemIndex];

          final bool isLeftAlign = itemIndex.isEven;

          final _TimelineChild child = _TimelineChild(
            itemData: itemData,
            isLeftAlign: isLeftAlign,
          );

          final bool isFirst = itemIndex == 0;
          final bool isLast = itemIndex == data.length - 1;
          double indicatorY;

          /// if is odd return the horizontal divider which is part of the timeline edges
          if (index.isOdd) {
            return const TimelineDivider(
              color: Colors.black,
              thickness: 5,
              begin: 0.1,
              end: 0.9,
            );
          }

          if (isFirst) {
            indicatorY = 0.2;

            /// Top
          } else if (isLast) {
            indicatorY = 0.8;

            /// Bottom
          } else {
            indicatorY = 0.5;

            /// Middle
          }

          /// if is NOT odd return the timeline child
          return TimelineTile(
            alignment: TimelineAlign.manual,
            endChild: isLeftAlign ? child : null,
            startChild: isLeftAlign ? null : child,
            lineXY: isLeftAlign ? 0.1 : 0.9,

            /// left to Right
            isFirst: isFirst,
            isLast: isLast,
            indicatorStyle: IndicatorStyle(
              width: 40,
              height: 40,

              /// Percent where the indicator should be positioned on line, from left to right
              indicatorXY: indicatorY,

              /// Indicator value, a Widget
              indicator: const _TimelineIndicator(icon: FontAwesomeIcons.globe),
            ),
            beforeLineStyle: const LineStyle(
              color: Colors.black,
              thickness: 5,
            ),
          );
        },
        childCount: max(0, data.length * 2 - 1),
      ),
    );
  }
}

class _TimelineIndicator extends StatelessWidget {
  const _TimelineIndicator({Key key, this.icon}) : super(key: key);

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.black,
      ),
      child: Icon(
        icon,
        color: Colors.white,
      ),
    );
  }
}

class _TimelineChild extends StatelessWidget {
  const _TimelineChild({
    Key key,
    this.itemData,
    this.isLeftAlign,
  }) : super(key: key);

  final NewsModel itemData;
  final bool isLeftAlign;

  @override
  Widget build(BuildContext context) {
    return itemData != null
        ? Padding(
            padding: isLeftAlign
                ? const EdgeInsets.only(
                    right: 32, top: 16, bottom: 16, left: 10)
                : const EdgeInsets.only(
                    left: 32, top: 16, bottom: 16, right: 10),
            child: Column(
              crossAxisAlignment: isLeftAlign
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                InkWell(
                  onTap: () {
                    AuthenticationService.launchURL(itemData.url);
                  },
                  child: Text(itemData.title,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                      style: Theme.of(context)
                          .primaryTextTheme
                          .bodyText1
                          .copyWith(
                              color: Colors.blueAccent,
                              fontWeight: FontWeight.bold),
                      textAlign:
                          isLeftAlign ? TextAlign.right : TextAlign.left),
                ),
                const SizedBox(height: 16),
                Text(
                  itemData.description,
                  textAlign: TextAlign.justify,
                  style: Theme.of(context)
                      .primaryTextTheme
                      .bodyText2
                      .copyWith(color: Colors.black),
                ),
                const SizedBox(height: 16),
                Align(
                  alignment:
                      isLeftAlign ? Alignment.topLeft : Alignment.topRight,
                  child: Text(
                    DateFormat("yyyy-MM-dd")
                        .format(DateTime.parse(itemData.pubDate))
                        .toString(),
                    style: Theme.of(context)
                        .primaryTextTheme
                        .bodyText2
                        .copyWith(
                            color: Colors.black54, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          )
        : const CircularProgressIndicator();
  }
}

class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Flexible(
          child: InkWell(
              onTap: () async {
                await AuthenticationService.launchURL(cdcURL);
              },
              child: Container(
                constraints: const BoxConstraints(maxHeight: 35, maxWidth: 35),
                child: Image.asset('images/cdc1.png'),
              )),
        ),
        Flexible(
          child: InkWell(
              onTap: () async {
                await AuthenticationService.launchURL(whoURL);
              },
              child: Container(
                constraints: const BoxConstraints(maxHeight: 35, maxWidth: 35),
                child: Image.asset('images/who.png'),
              )),
        ),
        Flexible(
          child: InkWell(
              onTap: () async {
                await AuthenticationService.launchURL(utdURL);
              },
              child: Container(
                constraints: BoxConstraints(maxHeight: 35, maxWidth: 35),
                child: Image.asset('images/utd.png'),
              )),
        ),
      ],
    );
  }
}
