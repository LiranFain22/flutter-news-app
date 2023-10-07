import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/articles/articles_bloc.dart';
import '../models/articles_data.dart';
import '../models/article.dart';
import '../models/error.dart';

class ArticlesRepository {
  static const apiKey = 'dc2819231371410b8fa16b586c17ee33';
  static const baseURL = 'https://newsapi.org/v2/everything';

  static Future<List<Article>> fetchArticlesBySearch(
      String searchKey, Emitter<ArticlesState> emit) async {
    try {
      Response response =
          await Dio().get('$baseURL?q=$searchKey&apiKey=$apiKey');
      ArticlesData articlesData = ArticlesData.fromJson(response.data);

      if (articlesData.status == 'ok') {
        return articlesData.articles;
      } else {
        // 'error'
        NewsError newsError = NewsError.fromJson(response.data);
        emit(ArticlesFetchingErrorState(error: newsError));
      }
      return [];
    } on DioException catch (e) {
      NewsError newsError = NewsError.fromJson(e.response!.data);
      emit(ArticlesFetchingErrorState(error: newsError));
      throw e.error.toString();
    }
  }

  static Future<List<Article>> fetchArticlesBySearchAndDates(String searchKey,
      String fromDate, String toDate, int page, Emitter<ArticlesState> emit) async {
    try {
      Response response = await Dio().get(
          '$baseURL?q=$searchKey&from=$fromDate&to=$toDate&page=$page&apiKey=$apiKey');
      ArticlesData articlesData = ArticlesData.fromJson(response.data);

      if (articlesData.status == 'ok') {
        return articlesData.articles;
      } else {
        // 'error'
        NewsError newsError = NewsError.fromJson(response.data);
        emit(ArticlesFetchingErrorState(error: newsError));
      }
      return [];
    } on DioException catch (_) {
      NewsError newsError = NewsError(
        status: 'error',
        code: 'Oops',
        message: 'Something went wrong\nPlease try again',
      );
      emit(ArticlesFetchingErrorState(error: newsError));
      return [];
    }
  }
}
