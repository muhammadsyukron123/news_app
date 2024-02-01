// save_news_usecase.dart
import '../../data/model/news_hive_model.dart';
import '../../data/repository.dart';
import '../entities/news_entity.dart';

class SaveNewsUseCase {
  var repository = Repository();

  Future<void> execute(NewsEntity news) async {
    try {
      final newsModel = News()
        ..id = news.id
        ..title = news.title
        ..imgurl = news.imageUrl
        ..url = news.link;

      // final News newsModel = _mapToModel(news);
      await repository.saveNews(newsModel);
    } catch (e) {
      throw e;
    }
  }

  // News _mapToModel(NewsEntity news) {
  //   return News(
  //     ..id: news.id,
  //     title: news.title,
  //     imgurl: news.imageUrl,
  //     url: news.link,
  //   );
  // }
}
