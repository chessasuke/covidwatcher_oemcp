class TheAppPath {
  final bool isHeatmap;
  final bool isSettings;
  final bool isNews;
  final bool isSelfReport;
  final bool isReportSent;
  final bool isSearchingBuilding;
  final bool isUnknown;

  TheAppPath.heatmap()
      : isHeatmap = true,
        isReportSent = false,
        isSettings = false,
        isUnknown = false,
        isSelfReport = false,
        isSearchingBuilding = false,
        isNews = false;

  TheAppPath.settings()
      : isSettings = true,
        isReportSent = false,
        isHeatmap = false,
        isUnknown = false,
        isSelfReport = false,
        isSearchingBuilding = false,
        isNews = false;

  TheAppPath.selfReport()
      : isSelfReport = true,
        isReportSent = false,
        isNews = false,
        isHeatmap = false,
        isSettings = false,
        isSearchingBuilding = false,
        isUnknown = false;

  TheAppPath.news()
      : isNews = true,
        isSelfReport = false,
        isReportSent = false,
        isHeatmap = false,
        isSettings = false,
        isSearchingBuilding = false,
        isUnknown = false;

  TheAppPath.searchingBuilding()
      : isSearchingBuilding = true,
        isReportSent = false,
        isUnknown = false,
        isHeatmap = false,
        isSettings = false,
        isSelfReport = false,
        isNews = false;

  TheAppPath.isReportSent()
      : isReportSent = true,
        isUnknown = false,
        isHeatmap = false,
        isSettings = false,
        isSelfReport = false,
        isSearchingBuilding = false,
        isNews = false;

  TheAppPath.unknown()
      : isUnknown = true,
        isHeatmap = false,
        isReportSent = false,
        isSettings = false,
        isSelfReport = false,
        isSearchingBuilding = false,
        isNews = false;

  bool get isHeatmapPage => isHeatmap == true;

  bool get isSettingsPage => isSettings == true;

  bool get isNewsPage => isNews == true;

  bool get isReportPage => isSelfReport == true;

  bool get isUnknownPage => isUnknown == true;

  bool get isSearchBuildingPage => isSearchingBuilding == true;

  bool get isReportSentPage => isReportSent == true;
}
