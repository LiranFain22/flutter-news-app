import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';

import '../../repositories/articles_repository.dart';
import '../../models/article.dart';
import '../../models/error.dart';

part 'articles_event.dart';
part 'articles_state.dart';

class ArticlesBloc extends Bloc<ArticlesEvent, ArticlesState> {
  ArticlesBloc() : super(ArticlesInitial()) {
    on<ArticlesInitialFetchEvent>(articlesInitialFetchEvent);
    on<ArticlesSearchEvent>(articlesSearchEvent);
  }

  FutureOr<void> articlesInitialFetchEvent(
      ArticlesInitialFetchEvent event, Emitter<ArticlesState> emit) async {
    emit(ArticlesFetchingLoadingState());

    List<Article> articles =
        await ArticlesRepository.fetchArticlesBySearch('apple', emit);

    if (articles.isEmpty) {
      NewsError newsError = NewsError(
          status: 'error',
          code: 'Oops...',
          message: 'No articles were found from the search results');
      emit(ArticlesFetchingErrorState(error: newsError));
    } else {
      emit(ArticlesFetchingSuccessfulState(articles: articles));
    }
  }

  FutureOr<void> articlesSearchEvent(
      ArticlesSearchEvent event, Emitter<ArticlesState> emit) async {
    try {
      List<Article> articles =
          await ArticlesRepository.fetchArticlesBySearchAndDates(
              event.searchKey, event.fromDate, event.toDate, emit);
      if (articles.isEmpty) {
        NewsError newsError = NewsError(
            status: 'error',
            code: 'Oops...',
            message: 'No articles were found from the search results');
        emit(ArticlesFetchingErrorState(error: newsError));
      } else {
        emit(ArticlesFetchingSuccessfulState(articles: articles));
      }
    } on DioException catch (e) {
      print(e.response);
      NewsError newsError = NewsError(
          status: 'error',
          code: 'No Articles',
          message: 'No articles were found from the search results');
      emit(ArticlesFetchingErrorState(error: newsError));
    }
  }
}
