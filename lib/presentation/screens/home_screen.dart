import 'package:flutter/material.dart';
import '../../domain/entities/news_entity.dart';
import '../../domain/usecases/get_news_usecase.dart';
import '../../domain/usecases/get_saved_news.dart';
import '../../domain/usecases/save_news_usecase.dart';
import '../widgets/favorites_card.dart';
import '../widgets/news_card.dart';
import 'favorites_screen.dart';
import 'news_screen.dart';

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





