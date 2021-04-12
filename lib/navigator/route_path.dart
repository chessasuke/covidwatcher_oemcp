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

  bool get isHeatmapPage =>
      isHeatmap == true &&
      isSettings == false &&
      isNews == false &&
      isSelfReport == false &&
      isReportSent == false &&
      isSearchingBuilding == false &&
      isUnknown == false;

  bool get isSettingsPage =>
      isSettings == true &&
      isHeatmap == false &&
      isNews == false &&
      isReportSent == false &&
      isSelfReport == false &&
      isSearchingBuilding == false &&
      isUnknown == false;

  bool get isNewsPage =>
      isNews == true &&
      isSettings == false &&
      isHeatmap == false &&
      isReportSent == false &&
      isSelfReport == false &&
      isSearchingBuilding == false &&
      isUnknown == false;

  bool get isReportPage =>
      isSelfReport == true &&
      isSettings == false &&
      isNews == false &&
      isHeatmap == false &&
      isReportSent == false &&
      isSearchingBuilding == false &&
      isUnknown == false;

  bool get isUnknownPage =>
      isUnknown == true &&
      isSettings == false &&
      isNews == false &&
      isSelfReport == false &&
      isSearchingBuilding == false &&
      isReportSent == false &&
      isHeatmap == false;

  bool get isSearchBuildingPage =>
      isSearchingBuilding == true &&
      isUnknown == false &&
      isSettings == false &&
      isNews == false &&
      isSelfReport == false &&
      isReportSent == false &&
      isHeatmap == false;

  bool get isReportSentPage =>
      isReportSent == true &&
      isSearchingBuilding == false &&
      isUnknown == false &&
      isSettings == false &&
      isNews == false &&
      isSelfReport == false &&
      isHeatmap == false;
}
