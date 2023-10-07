import 'dart:convert';

import 'article.dart';

ArticlesData articlesDataFromJson(String str) =>
    ArticlesData.fromJson(json.decode(str));

class ArticlesData {
  final String status;
  final int totalResults;
  final List<Article> articles;

  ArticlesData({
    required this.status,
    required this.totalResults,
    required this.articles,
  });

  factory ArticlesData.fromJson(Map<String, dynamic> json) => ArticlesData(
        status: json["status"],
        totalResults: json["totalResults"],
        articles: List<Article>.from(
            json["articles"].map((x) => Article.fromJson(x))),
      );
}
