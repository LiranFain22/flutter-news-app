import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';

import '../../repositories/articles_repository.dart';
import '../../models/article.dart';
import '../../models/error.dart';
import '../../utilities/box.dart';

part 'articles_event.dart';
part 'articles_state.dart';

class ArticlesBloc extends Bloc<ArticlesEvent, ArticlesState> {
  int currentPage = 1;

  ArticlesBloc() : super(ArticlesInitial()) {
    on<ArticlesInitialFetchEvent>(articlesInitialFetchEvent);
    on<ArticlesSearchEvent>(articlesSearchEvent);
    on<LoadMoreArticles>(fetchMoreArticles);
  }

  FutureOr<void> articlesInitialFetchEvent(
      ArticlesInitialFetchEvent event, Emitter<ArticlesState> emit) async {
    emit(ArticlesInitLoadingState());

    if (box.get('lastSearch') != null) {
      List<Article> articles = [];
      for (Article article in box.get('lastSearch')) {
        articles.add(article);
      }

      emit(ArticlesFetchingSuccessfulState(articles: articles));
    } else {
      // otherwise, fetching default articles
      try {
        List<Article> articles =
            await ArticlesRepository.fetchArticlesBySearch('apple', emit);

        if (articles.isEmpty) {
          NewsError newsError = NewsError(
              status: 'error',
              code: 'Oops...',
              message: 'No articles were found');
          emit(ArticlesFetchingErrorState(error: newsError));
        } else {
          // storing last search result (Case: user didn't search anything)
          box.put('lastSearch', articles);
          emit(ArticlesFetchingSuccessfulState(articles: articles));
        }
      } on DioException catch (e) {
        NewsError newsError = NewsError(
            status: 'error',
            code: 'Oops...',
            message: 'Something went wrong\nplease try again.');
        emit(ArticlesFetchingErrorState(error: newsError));
      }
    }
  }

  FutureOr<void> articlesSearchEvent(
      ArticlesSearchEvent event, Emitter<ArticlesState> emit) async {
    emit(ArticlesFetchingLoadingState());
    try {
      List<Article> articles =
          await ArticlesRepository.fetchArticlesBySearchAndDates(
              event.searchKey, event.fromDate, event.toDate, currentPage, emit);
      if (articles.isEmpty) {
        NewsError newsError = NewsError(
            status: 'error',
            code: 'Oops...',
            message: 'No articles were found');
        emit(ArticlesFetchingErrorState(error: newsError));
      } else {
        // Store the fetched articles in Hive
        box.put('lastSearch', articles);
        emit(ArticlesFetchingSuccessfulState(articles: articles));
      }
    } on DioException catch (e) {
      NewsError newsError = NewsError(
          status: 'error',
          code: 'Oops...',
          message: 'Something went wrong\nplease try again.');
      emit(ArticlesFetchingErrorState(error: newsError));
    }
  }

  FutureOr<void> fetchMoreArticles(
      LoadMoreArticles event, Emitter<ArticlesState> emit) async {
    if (state is ArticlesFetchingSuccessfulState) {
      final currentState = state as ArticlesFetchingSuccessfulState;
      final currentArticles = currentState.articles;

      try {
        List<Article> newArticles =
            await ArticlesRepository.fetchArticlesBySearchAndDates(
          event.searchKey,
          event.fromDate,
          event.toDate,
          currentPage + 1,
          emit,
        );

        if (newArticles.isNotEmpty) {
          List<Article> updatedArticles = List.of(currentArticles)
            ..addAll(newArticles);

          // Upadating the state
          emit(ArticlesFetchingSuccessfulState(articles: updatedArticles));

          currentPage++;
        }
      } on DioException catch (e) {
        NewsError newsError = NewsError(
            status: 'error',
            code: 'Oops...',
            message: 'Something went wrong\nplease try again.');
        emit(ArticlesFetchingErrorState(error: newsError));
      }
    }
  }
}
