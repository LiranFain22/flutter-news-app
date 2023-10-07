import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/articles/articles_bloc.dart';
import '../models/articles_data.dart';
import '../models/article.dart';
import '../models/error.dart';

class ArticlesRepository {
  static const apiKey1 = 'dc2819231371410b8fa16b586c17ee33'; // Mine
  static const apiKey2 = 'cfc78a450ce14db3870ffec96d88c85e';
  static const apiKey3 = 'a5707432dce64fc7916466177806dea4';
  static const baseURL = 'https://newsapi.org/v2/everything';

  static Future<List<Article>> fetchArticlesBySearch(
      String searchKey, Emitter<ArticlesState> emit) async {
    try {
      Response response =
          await Dio().get('$baseURL?q=$searchKey&apiKey=$apiKey2');
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
          '$baseURL?q=$searchKey&from=$fromDate&to=$toDate&page=$page&apiKey=$apiKey2');
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
