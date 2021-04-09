import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

//import '../heatmap/heatMap.dart';
import '../map/heatMap.dart';
import 'mobile_news.dart';
import 'mobile_report.dart';
import 'mobile_settings.dart';

class MobilePageManager extends StatefulWidget {
  @override
  _MobilePageManagerState createState() => _MobilePageManagerState();
}

class _MobilePageManagerState extends State<MobilePageManager> {
  PageController _pageController;
  int _selectedPageIndex;
  final List<Widget> _pages = [
    Heatmap(),
    NewsTimeline(),
    MobileReport(),
    MobileSettings(),
  ];

  @override
  void initState() {
    super.initState();

    _selectedPageIndex = 0;
    _pageController = PageController(initialPage: _selectedPageIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: _pages,
        ),
        bottomNavigationBar: SizedBox(
          height: 58,
          child: BottomNavigationBar(
            elevation: 20,
            currentIndex: _selectedPageIndex,
            onTap: (int selectedPageIndex) {
              setState(() {
                _selectedPageIndex = selectedPageIndex;

                /// transition animation
                _pageController.animateToPage(_selectedPageIndex,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeOut);
              });
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.mapMarkedAlt),
                label: 'Map',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.fiber_new_rounded),
                label: 'News',
              ),
              BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.wpforms),
                label: 'Report',
              ),
              BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.cog),
                label: 'Settings',
              ),
            ],
            unselectedItemColor: Theme.of(context).disabledColor,
            selectedItemColor: Theme.of(context).accentColor,
          ),
        ));
  }
}
