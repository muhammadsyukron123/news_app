
import '../../data/model/news_model.dart';
import '../../data/repository.dart';
import '../entities/news_entity.dart';

class GetNewsUseCase {


  var repository = Repository();

  Future<List<NewsEntity>> execute(String keyword) async {
    try {
      final List<NewsModel> newsList = await repository.getNews(keyword);
      return newsList.map((news) => _mapToEntity(news)).toList();
    } catch (e) {
      throw e;
    }
  }

  NewsEntity _mapToEntity(NewsModel news) {
    return NewsEntity(
      id: news.id,
      title: news.title,
      imageUrl: news.imageUrl,
      link: news.link,
    );
  }
}
