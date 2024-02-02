import 'package:hive/hive.dart';

import '../../domain/entities/news_entity.dart';
import '../model/news_hive_model.dart';
import '../model/news_model.dart';


class LocalDataSource {

  static const String boxName = 'news';

  Future<void> init() async {
    await Hive.openBox<News>(boxName);
  }

  Future<void> saveNews(News news) async {
    final box = await Hive.openBox<News>(boxName);
    await box.add(news);
  }

  Future<List<NewsEntity>> getSavedNews() async {
    final box = await Hive.openBox<News>(boxName);
    return box.values.map((news) => NewsEntity(
      id: news.id,
      title: news.title,
      imageUrl: news.imgurl,
      link: news.url,
    )).toList();
  }



}
