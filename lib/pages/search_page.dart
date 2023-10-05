import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:news_app/widgets/article_card.dart';
import 'package:news_app/widgets/news_appbar.dart';
import 'package:news_app/widgets/search_bar.dart';

import '../bloc/articles/articles_bloc.dart';
import '../widgets/news_error.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final ArticlesBloc articlesBloc = ArticlesBloc();
  var search = '';
  var fromDate =
      '${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}';
  var toDate =
      '${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}';

  @override
  void initState() {
    super.initState();
    articlesBloc.add(ArticlesInitialFetchEvent(search));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const NewsAppbar(
        isArticleTapped: false,
        actions: [],
      ),
      body: BlocConsumer<ArticlesBloc, ArticlesState>(
        bloc: articlesBloc,
        listenWhen: (previous, current) => current is ArticlesActionState,
        buildWhen: (previous, current) => current is! ArticlesActionState,
        listener: (context, state) {},
        builder: (context, state) {
          print(state.runtimeType);
          switch (state.runtimeType) {
            case ArticlesFetchingLoadingState:
              return const SpinKitCircle(
                color: Colors.blue,
                size: 50.0,
              );
            case ArticlesFetchingSuccessfulState:
              final successState = state as ArticlesFetchingSuccessfulState;
              final articles = successState.articles;
              return Column(
                children: [
                  SearchBar(
                    search: search,
                    fromDate: fromDate,
                    toDate: toDate,
                    onSearch: (search, fromDate, toDate) {
                      setState(() {
                        this.search = search;
                        this.fromDate = fromDate;
                        this.toDate = toDate;
                      });
                      articlesBloc.add(
                        ArticlesSearchEvent(
                          this.search,
                          this.fromDate,
                          this.toDate,
                        ),
                      );
                    },
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: articles.length,
                      itemBuilder: (context, index) {
                        final article = articles[index];
                        return ArticleCard(article: article);
                      },
                    ),
                  ),
                ],
              );
            case ArticlesFetchingErrorState:
              final currentState = state as ArticlesFetchingErrorState;
              final error = currentState.error;
              return Column(
                children: [
                  SearchBar(
                    search: search,
                    fromDate: fromDate,
                    toDate: toDate,
                    onSearch: (search, fromDate, toDate) {
                      setState(() {
                        this.search = search;
                        this.fromDate = fromDate;
                        this.toDate = toDate;
                      });
                      articlesBloc.add(
                        ArticlesSearchEvent(
                          this.search,
                          this.fromDate,
                          this.toDate,
                        ),
                      );
                    },
                  ),
                  NewsErrorWidget(error: error),
                ],
              );
            default:
              return Center(
                child: Column(
                  children: [
                    SearchBar(
                      search: search,
                      fromDate: fromDate,
                      toDate: toDate,
                      onSearch: (search, fromDate, toDate) {
                        setState(() {
                          this.search = search;
                          this.fromDate = fromDate;
                          this.toDate = toDate;
                        });
                        articlesBloc.add(
                          ArticlesSearchEvent(
                            this.search,
                            this.fromDate,
                            this.toDate,
                          ),
                        );
                      },
                    ),
                    const Expanded(
                      child: Text(
                          "Something Went Wrong\nPlease try again later..."),
                    ),
                  ],
                ),
              );
          }
        },
      ),
    );
  }
}
