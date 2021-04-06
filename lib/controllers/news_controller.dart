import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/news_model.dart';
import '../service/news_service.dart';

final newsProvider = ChangeNotifierProvider<NewsController>((ref) {
  return NewsController();
});

class NewsController extends ChangeNotifier {
  NewsController() {
    _newsList = [];
    updateList();
  }

  List<NewsModel> _newsList;

  UnmodifiableListView<NewsModel> get getList => UnmodifiableListView(_newsList
      .expand((NewsModel newsItem) {
        return _newsList;
      })
      .toSet()
      .toList(growable: false));

  int _page = 0;
  final int _pageSize = 100;

  /// TODO check if performace parsing the json is compromised (takes more than 16 miliseconds),
  /// if so move the computation to an isolate using the compute() function

  /// UPDATE NEWS LIST
  Future<void> updateList() async {
    final responseBody =
        await NewsService.sendRequest(pageIndex: _page, pageSize: _pageSize);

//    print('responseBody: $responseBody');

    if (responseBody.isNotEmpty) {
      /// Decode with UTF8 to avoid messed up characters
      final List<int> codeUnits = responseBody.codeUnits;
      final decodeData = const Utf8Decoder().convert(codeUnits);

      /// extract content from json into List<dynamic>
      final List<dynamic> parsed =
          jsonDecode(decodeData)['hits'] as List<dynamic>;

//      print('hits ${parsed.length} results');
      bool contains = false;

      List<NewsModel> newItemList = [];
      if (parsed != null && parsed.isNotEmpty) {
        for (int i = 0; i < parsed.length; i++) {
          final Map<String, dynamic> temp = parsed[i] as Map<String, dynamic>;
          final newsItem = NewsModel.fromJson(temp);

          /// TODO - Thinks for a preformance improvement here
          /// Problem: many fo the fetched news are duplicated except for the url,
          /// so a set doesnt actually find duplicates because the url of the instance is different
          /// check for duplicate properties in every news instance is expensive
          ///

          /// TODO this is really bad, we are checking all news items of our repository
          /// Ideally we will have a cursor for the new items fetched but the API doesnt support this
          /// Best solution is to move that logic to the server but to use server functions,
          /// billing must be enable.
          /// For now we are checking the whole list again for duplicates
          ///
          contains = false;
          newItemList.forEach((NewsModel element) {
            if (element.title == newsItem.title) {
              contains = true;
            }
          });
          if (contains == false) {
            newItemList.add(newsItem);
          }
        }
      }
      _newsList = newItemList;
      notifyListeners();
    }
  }
}
