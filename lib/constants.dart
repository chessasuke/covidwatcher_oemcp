const String visitorReportEmail = 'c19resource@utdallas.edu';
const String reportEmailSubject = 'UT Dallas Visitor Self-Report Form';
const String reportEmailBody =
    'Please enter relevant information like contact information, locations visited, and date of visit.';

//const String newsApiKey = '0de4a7jbspnf4n4z41hbdwyty';
const String newsApiKey2 = '1a9d477a5a734143a4e22cc710e0f2c2';
//const String news_url = 'https://datanews.io/';

/// Version 2 Datanews endpoints
const String endpointNewsV2_1 = '/v2/everything';
//const String endpointNewsV2_2 = '/v2/top-headlines';

///// Searching
//const String endpointNews = 'api.datanews.io/v1/news';
//const String endpointHeadlines = 'api.datanews.io/v1/headlines';
//const String endpointSources = 'api.datanews.io/v1/sources';
//
///// Monitoring
//const String createMonitor = 'api.datanews.io/v1/monitors/create';
//const String listMonitor = 'api.datanews.io/v1/monitors/list';
//const String getMonitorById = 'api.datanews.io/v1/monitors/list/{id}';
//const String deleteMonitor = 'api.datanews.io/v1/monitors/delete/{id}';
//const String getMonitorResults = 'api.datanews.io/v1/monitors/latest/{run_id}';
//
///// StatusCode
//const String requestSucceeded = '200 - OK';
//const String requestInvalid = '400 - Bad Request';
//const String apiInvalid = '401 - Unauthorized';
//const String accountInvalid = '403 - Forbidden';
//const String resourceNotFound = '404 - Not Found';
//const String tooManyRequests = '429 - Too Many Requests';

/// Starts with 5 - Server error
const String serverError = '500, 502, 503, 504 - Server Error';

const String whoURL = 'https://www.who.int/';
const String cdcURL = 'https://www.cdc.gov/';
const String utdURL = 'https://covid.utdallas.edu/';

///---------For Mercator class------------------

/// UTD center long/lat
const utdCenterLong = -96.7501;
const utdCenterLat = 32.9800;

/// UTD center X/Y
//final double utdCenterX = Mercator.xAxisProjection(-96.7501);
//final double utdCenterY = Mercator.yAxisProjection(32.9800);
//
//final double utdCenterX2 = Mercator.xAxisProjection(-96.740728);
//final double utdCenterY2 = Mercator.yAxisProjection(32.968878);

final double convertedCenterX = -10770171.866198298;
final double convertedCenterY = 3892649.5986903203;

final offsetX = 678.4811644330621;
final offsetY = -899.5897214519791;

const List<String> menu = ['Heatmap', 'News', 'Self-Report', 'Settings'];

const String OEMCP_SELF_REPORT_URL =
    'https://veoci.com/veoci/p/form/tqeyzbbexcyf?c=131560#tab=entryForm';

const String OEMCP_VACCINE_REPORT_URL =
    'https://www.utdallas.edu/covid/response/vaccine-clinic/';
