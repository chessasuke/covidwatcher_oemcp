class TheAppPath {
  final bool isHome;
  final bool isSettings;
  final bool isUnknown;

  TheAppPath.settings()
      : isHome = false,
        isSettings = true,
        isUnknown = false;

  TheAppPath.home()
      : isHome = true,
        isSettings = false,
        isUnknown = false;

  TheAppPath.unknown()
      : isUnknown = true,
        isHome = false,
        isSettings = false;

  bool get isHomePage => isHome == true;
  bool get isSettingsPage => isSettings == true && isUnknown == false;
  bool get isUnknownPage => isUnknown == true && isSettings == false;
}
