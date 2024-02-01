

import '../../data/model/news_model.dart';
import '../../data/repository.dart';
import '../entities/news_entity.dart';

class GetSavedNewsUseCase {
  var repository = Repository();

  Future<List<NewsEntity>> execute() async {
    try {
      final List<NewsEntity> newsList = await repository.getSavedNews(); // Mengubah tipe data menjadi List<NewsEntity>
      return newsList;
    } catch (e) {
      throw e;
    }
  }
}
