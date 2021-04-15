import 'package:shared_preferences/shared_preferences.dart';

Future<String> setNotifierBuildings(List<String> subscribedBuildings) async {
  print('set new buildings: ${subscribedBuildings.length}');
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  final bool success = await prefs.setStringList('sub', subscribedBuildings);
  if (success) {
    return 'ok';
  } else {
    return 'error';
  }
}

Future<void> removeNotifierBuilding(String building) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final List<String> buildings = prefs.getStringList('sub')
    ..removeWhere((element) => element.toLowerCase() == building.toLowerCase());
  await prefs.setStringList('sub', buildings);
}

Future<List<String>> getNotifierBuildings() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getStringList('sub');
}

Future<void> restoreSettings() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final showBookmarked = await prefs.getBool('showBookmarked');
  final showStructureMarker = await prefs.getBool('showStructureMarker');
  final showBuildingMarker = await prefs.getBool('showBuildingMarker');
  final subscribedBuildings = await prefs.getStringList('subscribedBuildings');
  final filterDate = await prefs.getString('filterDate');
  final filterRate = await prefs.getString('filterRate');
  return Settings(
    showBookmarked: showBookmarked,
    showStructureMarker: showStructureMarker,
    showBuildingMarker: showBuildingMarker,
    subscribedBuildings: subscribedBuildings,
    filterDate: filterDate,
    filterRate: filterRate,
  );
}

Future<void> saveSettings(Settings settings) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool('showBookmarked', settings.showBookmarked);
  await prefs.setBool('showStructureMarker', settings.showStructureMarker);
  await prefs.setBool('showBuildingMarker', settings.showBuildingMarker);
  await prefs.setStringList(
      'subscribedBuildings', settings.subscribedBuildings);
  await prefs.setString('filterDate', settings.filterDate);
  await prefs.setString('filterRate', settings.filterRate);
}

class Settings {
  final bool showStructureMarker;
  final bool showBuildingMarker;
  final bool showBookmarked;
  final String filterDate;
  final String filterRate;
  final List<String> subscribedBuildings;

  Settings(
      {this.showBookmarked = false,
      this.showBuildingMarker = false,
      this.showStructureMarker = false,
      this.filterDate = 'Last Month',
      this.filterRate = '+0',
      this.subscribedBuildings = const []});
}
