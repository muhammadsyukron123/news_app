import 'package:http/http.dart' as http;
import 'dart:convert';

import '../model/news_model.dart';


class RemoteDataSource {
  final String baseUrl = 'https://newsapi.org/v2/everything';
  final String apiKey = '81ef520927314c8e83cc27ddd8286fa5';

  Future<List<NewsModel>> fetchNews(String keyword) async {
    final response = await http.get(Uri.parse('$baseUrl?q=$keyword&apiKey=$apiKey'));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      List<NewsModel> newsList = [];
      for (var item in jsonData['articles']) {
        newsList.add(NewsModel.fromJson(item));
      }
      return newsList;
    } else {
      throw Exception('Failed to load news');
    }
  }
}
