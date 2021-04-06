import 'package:flutter/material.dart';
import 'responsive.dart';

class FlexFontSize {
  /// Return font size according to screen
  static TextTheme getFontSize(BuildContext context) {
    if (ResponsiveWidget.isSmallMobileScreen(context)) {
      /// Mobile Screen <500 px
      return TextTheme(
        headline1: TextStyle(fontSize: 24), // title
        headline2: TextStyle(fontSize: 20), // description
        bodyText1: TextStyle(fontSize: 16), // normal
        bodyText2: TextStyle(fontSize: 13), // normal
      );
    } else if (ResponsiveWidget.isMobileScreen(context)) {
      /// Mobile Screen <500 px
      return TextTheme(
        headline1: TextStyle(fontSize: 32), // title
        headline2: TextStyle(fontSize: 24), // description
        bodyText1: TextStyle(fontSize: 20), // normal
        bodyText2: TextStyle(fontSize: 15), // normal
      );
    } else if (ResponsiveWidget.isSmallScreen(context)) {
      /// Small Screen 500-800 px
      return TextTheme(
        headline1: TextStyle(fontSize: 38), // title
        headline2: TextStyle(fontSize: 32), // description
        bodyText1: TextStyle(fontSize: 22), // normal
        bodyText2: TextStyle(fontSize: 16), // normal
      );
    } else {
      /// Screen >800 px
      return const TextTheme(
        headline1: TextStyle(fontSize: 48), // title
        headline2: TextStyle(fontSize: 32), // description
        bodyText1: TextStyle(fontSize: 24), // normal
        bodyText2: TextStyle(fontSize: 18), // normal
      );
    }
  }
}
