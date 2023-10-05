import 'dart:convert';

import 'package:hive/hive.dart';

import 'article.dart';

part "articles_data.g.dart";

ArticlesData articlesDataFromJson(String str) =>
    ArticlesData.fromJson(json.decode(str));

@HiveType(typeId: 2)
class ArticlesData {
  @HiveField(0)
  final String status;
  @HiveField(1)
  final int totalResults;
  @HiveField(2)
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

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'totalResults': totalResults,
      'articles': List<dynamic>.from(articles.map((x) => x.toJson())),
    };
  }
}
