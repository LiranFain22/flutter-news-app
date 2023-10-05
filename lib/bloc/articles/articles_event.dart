part of 'articles_bloc.dart';

@immutable
abstract class ArticlesEvent {}

class ArticlesInitialCacheBox extends ArticlesEvent {}

class ArticlesInitialFetchEvent extends ArticlesEvent {
  final String? searchKey;

  ArticlesInitialFetchEvent(this.searchKey);
}

class ArticlesSearchEvent extends ArticlesEvent {
  final String searchKey;
  final String fromDate;
  final String toDate;

  ArticlesSearchEvent(
    this.searchKey,
    this.fromDate,
    this.toDate,
  );
}
