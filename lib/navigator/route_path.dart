class TheAppPath {
  final bool isHeatmap;
  final bool isSettings;
  final bool isNews;
  final bool isSelfReport;
  final bool isSearchingBuilding;
//  final bool isSignIn;
  final bool isUnknown;

  TheAppPath.heatmap()
      : isHeatmap = true,
        isSettings = false,
        isUnknown = false,
        isSelfReport = false,
        isSearchingBuilding = false,
//        isSignIn = false,
        isNews = false;

  TheAppPath.settings()
      : isSettings = true,
        isHeatmap = false,
        isUnknown = false,
        isSelfReport = false,
        isSearchingBuilding = false,
//        isSignIn = false,
        isNews = false;

  TheAppPath.selfReport()
      : isSelfReport = true,
        isNews = false,
        isHeatmap = false,
        isSettings = false,
        isSearchingBuilding = false,
//        isSignIn = false,
        isUnknown = false;

  TheAppPath.news()
      : isNews = true,
        isSelfReport = false,
        isHeatmap = false,
        isSettings = false,
        isSearchingBuilding = false,
//        isSignIn = false,
        isUnknown = false;

  TheAppPath.searchingBuilding()
      : isSearchingBuilding = true,
        isUnknown = false,
        isHeatmap = false,
        isSettings = false,
        isSelfReport = false,
//        isSignIn = false,
        isNews = false;

//  TheAppPath.signIn()
//      : isSignIn = true,
//        isSearchingBuilding = false,
//        isUnknown = false,
//        isHeatmap = false,
//        isSettings = false,
//        isSelfReport = false,
//        isNews = false;

  TheAppPath.unknown()
      : isUnknown = true,
        isHeatmap = false,
        isSettings = false,
        isSelfReport = false,
//        isSignIn = false,
        isSearchingBuilding = false,
        isNews = false;

  bool get isHeatmapPage =>
      isHeatmap == true &&
      isSettings == false &&
      isNews == false &&
      isSelfReport == false &&
      isSearchingBuilding == false &&
//      isSignIn == false &&
      isUnknown == false;
  bool get isSettingsPage =>
      isSettings == true &&
      isHeatmap == false &&
      isNews == false &&
      isSelfReport == false &&
      isSearchingBuilding == false &&
//      isSignIn == false &&
      isUnknown == false;
  bool get isNewsPage =>
      isNews == true &&
      isSettings == false &&
      isHeatmap == false &&
      isSelfReport == false &&
      isSearchingBuilding == false &&
//      isSignIn == false &&
      isUnknown == false;
  bool get isReportPage =>
      isSelfReport == true &&
      isSettings == false &&
      isNews == false &&
      isHeatmap == false &&
      isSearchingBuilding == false &&
//      isSignIn == false &&
      isUnknown == false;
  bool get isUnknownPage =>
      isUnknown == true &&
      isSettings == false &&
      isNews == false &&
      isSelfReport == false &&
      isSearchingBuilding == false &&
//      isSignIn == false &&
      isHeatmap == false;
  bool get isSearchBuildingPage =>
      isSearchingBuilding == true &&
      isUnknown == false &&
      isSettings == false &&
      isNews == false &&
      isSelfReport == false &&
//      isSignIn == false &&
      isHeatmap == false;
  bool get isSignInPage =>
//      isSignIn == true &&
      isSearchingBuilding == false &&
      isUnknown == false &&
      isSettings == false &&
      isNews == false &&
      isSelfReport == false &&
      isHeatmap == false;
}
