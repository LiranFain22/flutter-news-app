import 'package:flutter/material.dart';

import 'pages/search_page.dart';

void main() {
  runApp(const MainApp());
}

// void main() async {
//   await Hive.initFlutter();
//   Hive.registerAdapter(ArticleAdapter());
//   Hive.registerAdapter(ArticlesDataAdapter());
//   runApp(const MainApp());
// }

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
