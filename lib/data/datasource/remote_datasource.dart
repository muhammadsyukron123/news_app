import 'package:http/http.dart' as http;
import 'dart:convert';

import '../model/news_model.dart';


class RemoteDataSource {
  final String baseUrl = 'https://newsapi.org/v2/everything';
  final String apiKey = '4b397c0b925c48649a61b00c6ab69622';

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
