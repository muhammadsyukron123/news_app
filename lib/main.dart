import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:news_app/presentation/screens/home_screen.dart';

import 'data/model/news_hive_model.dart';

// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   Hive.initFlutter();
//   Hive.openBox('news');
//
//   runApp(const MyApp());
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(NewsAdapter());
  // await Hive.openBox('news');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomeScreen(),
    );
  }
}
