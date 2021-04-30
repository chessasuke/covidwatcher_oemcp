import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:covid_watcher/app_themes/theme.dart';


/// THIS FILE CONTAINS PROVIDERS CONNECTED TO THE APP THEME MODULE

final appThemeProvider = ChangeNotifierProvider<AppDynamicTheme>((ref) {
  return AppDynamicTheme();
});