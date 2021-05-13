import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../constants.dart';

class NewsService {
  static Future<String> requestNews(
      {
//        String authority = 'api.datanews.io',
      String authority = 'newsapi.org',
      String endpoint = '/v2/everything',
      int pageIndex = 0,
      pageSize = 25}) async {
    print('----------------------Sending HTTP Request---------------------');

    /// Request news from the last 2 weeks (Date.now - 14 days)
    String toDate = DateFormat("yyyy-MM-dd").format(DateTime.now()).toString();
    String fromDate = DateFormat("yyyy-MM-dd")
        .format(DateTime.parse(toDate).subtract(const Duration(days: 14)))
        .toString();

    /// hardcoded
    final parameters = {
      'apiKey': newsApiKey2,
      'q': '+covid',
//      'q': 'covid AND ("university of texas at dallas")',
//      'page': pageIndex.toString(),
//      'pageSize': pageSize.toString(),
      'sortBy': 'relevancy', //relevance
      'language': 'en',
      'source': 'the dallas morning news',
//      'qInTitle': '"university of texas at dallas"',
      'from': fromDate,
      'to': toDate,
    };

    http.Response response;
    try {
      response = await http.get(Uri.https(authority, endpoint, parameters));
    } catch (e) {
      print('error: $e');
    }

    print('response.statusCode: ${response.statusCode}');

    return response.body;
  }

  /// Using DIO package - TODO doesnt work fixed
//  static Future<String> dioSendRequest() async {
//    String url = 'api.datanews.io/v1/news';
//
//    final thisDio = dio.Dio();
//
//    /// hardcoded
//    final Map<String, dynamic> parameters = {
//      'apiKey': newsApiKey,
//      'q': 'dallas+australia+europe',
//      'from': '2021-03-01',
//      'to': '2021-03-02',
//      'language': 'en',
//      'sortBy': 'date',
//      'page': '0',
//      'size': '1',
//    };
//
//    dio.Response response = await thisDio.get(url, queryParameters: parameters);
//
//    print('response.statusCode: ${response.statusCode}');
//    print('response.data: ${response.data}');
//
////    return response.body;
//  }
}
