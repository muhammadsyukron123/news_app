import 'package:flutter/material.dart';
import '../../domain/entities/news_entity.dart';
import '../../domain/usecases/get_news_usecase.dart';
import '../../domain/usecases/get_saved_news.dart';
import '../../domain/usecases/save_news_usecase.dart';
import '../widgets/favorites_card.dart';
import '../widgets/news_card.dart';

class HomeScreen extends StatefulWidget {
  var getNewsUseCase = GetNewsUseCase();
  var saveNewsUseCase = SaveNewsUseCase();
  var getSavedNewsUseCase = GetSavedNewsUseCase();

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News App'),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'News'),
            Tab(text: 'Favorites'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          NewsTab(getNewsUseCase: widget.getNewsUseCase, saveNewsUseCase: widget.saveNewsUseCase),
          FavoritesTab(getSavedNewsUseCase: widget.getSavedNewsUseCase),
        ],
      ),
    );
  }
}

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

