import 'package:hive/hive.dart';
import 'package:news_app/domain/entities/news_entity.dart';

import 'datasource/local_datasource.dart';
import 'datasource/remote_datasource.dart';
import 'model/news_hive_model.dart';
import 'model/news_model.dart';

class Repository {

  var remoteDataSource = RemoteDataSource();
  var localDataSource = LocalDataSource();

  Future<List<NewsModel>> getNews(String keyword) async {
    try {
      // Ambil berita dari remote data source
      final List<NewsModel> newsList = await remoteDataSource.fetchNews(keyword);

      // Simpan berita ke dalam local data source
      // for (var news in newsList) {
      //   await localDataSource.saveNews(news);
      // }

      return newsList;
    } catch (e) {
      throw e;
    }
  }

  Future<List<NewsEntity>> getSavedNews() async {
    try {
      // Ambil berita yang disimpan dari local data source
      final List<NewsEntity> newsList = await localDataSource.getSavedNews();
      return newsList;
    } catch (e) {
      throw e;
    }
  }

  Future<void> saveNews(News news) async {
    try {
      await localDataSource.saveNews(news);
    } catch (e) {
      throw e;
    }
  }

  // Fungsi untuk memeriksa apakah berita sudah disimpan di database favorit atau tidak
  Future<bool> isNewsSaved(String newsId) async {
    final box = await Hive.openBox<News>('news');
    return box.values.any((news) => news.id == newsId);
  }

  // Fungsi untuk menyimpan berita ke database favorit
  Future<void> toggleNewsFavorite(News news) async {
    final box = await Hive.openBox<News>('news');
    if (box.containsKey(news.id)) {
      await box.delete(news.id); // Hapus berita jika sudah ada
    } else {
      await box.put(news.id, news); // Simpan berita jika belum ada
    }
  }



}
