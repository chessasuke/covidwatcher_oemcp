class TheAppPath {
  String id;
  final bool isHeatmap;
  final bool isSettings;
  final bool isNotification;
  final bool isNews;
  final bool isSelfReport;
  final bool isUnknown;

  TheAppPath.heatmap()
      : isHeatmap = true,
        isSettings = false,
        isNotification = false,
        isUnknown = false,
        isSelfReport = false,
        isNews = false;

  TheAppPath.settings()
      : isSettings = true,
        isNotification = false,
        isHeatmap = false,
        isUnknown = false,
        isSelfReport = false,
        isNews = false;

  TheAppPath.selfReport()
      : isSelfReport = true,
        isNotification = false,
        isNews = false,
        isHeatmap = false,
        isSettings = false,
        isUnknown = false;

  TheAppPath.news()
      : isNews = true,
        isSelfReport = false,
        isNotification = false,
        isHeatmap = false,
        isSettings = false,
        isUnknown = false;

  TheAppPath.notification({this.id})
      : isNotification = true,
        isNews = false,
        isSelfReport = false,
        isHeatmap = false,
        isSettings = false,
        isUnknown = false;

  TheAppPath.unknown()
      : isUnknown = true,
        isNotification = false,
        isHeatmap = false,
        isSettings = false,
        isSelfReport = false,
        isNews = false;

  bool get isHeatmapPage => isHeatmap == true;

  bool get isSettingsPage => isSettings == true;

  bool get isNotificationPage => isNotification == true;

  bool get isNewsPage => isNews == true;

  bool get isReportPage => isSelfReport == true;

  bool get isUnknownPage => isUnknown == true;
}
