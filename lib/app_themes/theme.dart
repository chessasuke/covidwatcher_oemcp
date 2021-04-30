import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final appThemeProvider = ChangeNotifierProvider<AppDynamicTheme>((ref) {
  return AppDynamicTheme();
});

class AppDynamicTheme extends ChangeNotifier {
  AppDynamicTheme();

  static bool isDark = true;

  void toggle() {
    isDark = !isDark;
    notifyListeners();
  }

  ThemeData getTheme() {
    return isDark ? darkTheme : lightTheme;
  }

  /// DARK
  static final ThemeData darkTheme = ThemeData(
    primarySwatch: Colors.grey,
    backgroundColor: Colors.black,
    disabledColor: Colors.white30,
    appBarTheme: const AppBarTheme(
        iconTheme: IconThemeData(color: Colors.white),
        color: Colors.black,
        shadowColor: Colors.black,
        brightness: Brightness.dark,
        elevation: 50),
    accentColor: Colors.lightBlue,
    cardColor: Colors.lightBlueAccent.withOpacity(0.75),
    primaryTextTheme: TextTheme(
      button: TextStyle(
        color: Colors.blueGrey[200],
        decorationColor: Colors.blueGrey[50],
      ),

      /// Default to large screen
      /// AdaptableText handles fontsize for other screen sizes
      ///
      /// Titles (Extremely Large text)
      headline1: const TextStyle(fontSize: 48, color: Colors.white), // title
      /// Subtitles (Very Large Text)
      headline2:
          const TextStyle(fontSize: 36, color: Colors.white), // description
      /// Standard text for small screen
      bodyText1: const TextStyle(
        fontSize: 20,
        color: Colors.white,
      ), // normal
      /// Standard text for large screen
      bodyText2: const TextStyle(
        fontSize: 18,
        color: Colors.white,
      ), // normal
    ),
    textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
            primary: Colors.lightBlueAccent, elevation: 50)),
    bottomAppBarColor: Colors.black,
    iconTheme: IconThemeData(color: Colors.blueGrey[200]),
    brightness: Brightness.dark,
  );

  /// LIGHT
  static final ThemeData lightTheme = ThemeData(
    primarySwatch: Colors.blueGrey,
    backgroundColor: Colors.white.withOpacity(0.35),
    disabledColor: Colors.black38,
    appBarTheme: const AppBarTheme(
        iconTheme: IconThemeData(color: Colors.black),
        color: Colors.white,
        shadowColor: Colors.grey,
        brightness: Brightness.light,
        elevation: 50),
    accentColor: Colors.blueAccent,
    cardColor: Colors.lightBlueAccent.withOpacity(0.75),
    primaryTextTheme: TextTheme(
      button: TextStyle(
        color: Colors.blueGrey,
        decorationColor: Colors.blueGrey[300],
      ),

      /// Default to large screen
      /// AdaptableText handles fontsize for other screen sizes
      ///
      /// Titles (Extremely Large text)
      headline1:
          const TextStyle(fontSize: 48, color: Colors.black), // description
      /// Subtitles (Very Large Text)
      headline2: const TextStyle(fontSize: 36, color: Colors.black), // title
      bodyText1: const TextStyle(
        fontSize: 20,
        color: Colors.black,
      ), // normal
      /// Default text (normal body text)
      bodyText2: const TextStyle(
        fontSize: 18,
        color: Colors.black,
      ), // normal
    ),
    textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
            primary: Colors.lightBlueAccent, elevation: 30)),
    bottomAppBarColor: Colors.blueGrey[900],
    iconTheme: const IconThemeData(color: Colors.blueGrey),
    brightness: Brightness.light,
  );
}
