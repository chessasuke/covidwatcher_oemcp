import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../constants.dart';

class NewsService {
  static Future<String> requestNews(
      {String authority = 'api.datanews.io',
      String path = '/v1/news',
      int pageIndex = 0,
      pageSize = 100}) async {
    print('----------------------Sending HTTP Request---------------------');

    /// Request news from the last 2 weeks (Date.now - 14 days)
    String toDate = DateFormat("yyyy-MM-dd").format(DateTime.now()).toString();
    String fromDate = DateFormat("yyyy-MM-dd")
        .format(DateTime.parse(toDate).subtract(const Duration(days: 14)))
        .toString();

    /// hardcoded
    final parameters = {
      'apiKey': newsApiKey,
      'q': '(covid+university+of+texas+at+dallas)',
      'from': fromDate,
      'to': toDate,
      'language': 'en',
      'page': pageIndex.toString(),
      'size': pageSize.toString(),
      'sortBy': 'relevance', //relevance
    };

    http.Response response;
    try {
      response = await http.get(Uri.http(authority, path, parameters));
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
