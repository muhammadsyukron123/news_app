import 'package:flutter/material.dart';

import '../../domain/entities/news_entity.dart';
import '../../domain/usecases/get_saved_news.dart';
import '../widgets/favorites_card.dart';

class FavoritesTab extends StatelessWidget {
  final GetSavedNewsUseCase getSavedNewsUseCase;

  FavoritesTab({required this.getSavedNewsUseCase});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<NewsEntity>>(
      future: getSavedNewsUseCase.execute(),
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
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final news = snapshot.data![index];
              return FavoritesCard(
                news: news,
              );
            },
          );
        }
      },
    );
  }
}