class TheAppPath {
  final bool isHeatmap;
  final bool isSettings;
  final bool isNews;
  final bool isSelfReport;
  final bool isUnknown;

  TheAppPath.heatmap()
      : isHeatmap = true,
        isSettings = false,
        isUnknown = false,
        isSelfReport = false,
        isNews = false;

  TheAppPath.settings()
      : isSettings = true,
        isHeatmap = false,
        isUnknown = false,
        isSelfReport = false,
        isNews = false;

  TheAppPath.selfReport()
      : isSelfReport = true,
        isNews = false,
        isHeatmap = false,
        isSettings = false,
        isUnknown = false;

  TheAppPath.news()
      : isNews = true,
        isSelfReport = false,
        isHeatmap = false,
        isSettings = false,
        isUnknown = false;

  TheAppPath.unknown()
      : isUnknown = true,
        isHeatmap = false,
        isSettings = false,
        isSelfReport = false,
        isNews = false;

  bool get isHeatmapPage => isHeatmap == true;

  bool get isSettingsPage => isSettings == true;

  bool get isNewsPage => isNews == true;

  bool get isReportPage => isSelfReport == true;

  bool get isUnknownPage => isUnknown == true;
}
