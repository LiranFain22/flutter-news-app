import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import './models/article.dart';
import './models/source.dart';

import './utilities/box.dart';

import 'pages/search_page.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ArticleAdapter());
  Hive.registerAdapter(SourceAdapter());
  box = await Hive.openBox('articlesBox');
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: SearchPage(),
        ),
      ),
    );
  }
}
