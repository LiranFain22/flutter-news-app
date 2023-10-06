part of 'articles_bloc.dart';

@immutable
abstract class ArticlesState {}

abstract class ArticlesActionState extends ArticlesState {}

class ArticlesInitial extends ArticlesState {}

class ArticlesInitLoadingState extends ArticlesState {}

class ArticlesFetchingLoadingState extends ArticlesState {}

class ArticlesFetchingErrorState extends ArticlesState {
  final NewsError error;

  ArticlesFetchingErrorState({
    required this.error,
  });
}

class ArticlesFetchingSuccessfulState extends ArticlesState {
  final List<Article> articles;

  ArticlesFetchingSuccessfulState({
    required this.articles,
  });
}
