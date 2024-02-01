import 'package:flutter/material.dart';
import 'package:news_app/presentation/widgets/webview_screen.dart';

import '../../domain/entities/news_entity.dart';


class FavoritesCard extends StatelessWidget {
  final NewsEntity news;

  FavoritesCard({required this.news});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: ListTile(
        title: Text(news.title,style: TextStyle(fontWeight: FontWeight.bold),),
        trailing: Icon(Icons.arrow_forward_ios_outlined),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => WebViewScreen(url: news.link),
            ),
          );
        },
      ),
    );
  }
}
