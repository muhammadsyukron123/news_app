import 'package:flutter/material.dart';

import '../../domain/entities/news_entity.dart';
import '../../domain/usecases/get_news_usecase.dart';
import '../../domain/usecases/save_news_usecase.dart';
import '../widgets/news_card.dart';

class NewsTab extends StatelessWidget {
  final GetNewsUseCase getNewsUseCase;
  final SaveNewsUseCase saveNewsUseCase;

  NewsTab({required this.getNewsUseCase, required this.saveNewsUseCase});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async{
        await getNewsUseCase.execute("keyword");
      },
      child: FutureBuilder<List<NewsEntity>>(
        future: getNewsUseCase.execute("keyword"),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            return ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                final news = snapshot.data![index];
                return NewsCard(
                  news: news,
                  onSave: () async {
                    // Tambahkan logika untuk menyimpan berita ke favorit di sini
                    await saveNewsUseCase.execute(news);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Berita disimpan ke favorit'),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}