import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../widgets/news_appbar.dart';
import '../models/article.dart';
import '../widgets/row_info.dart';

class DetailsPage extends StatefulWidget {
  final Article article;

  const DetailsPage({
    super.key,
    required this.article,
  });

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  late final WebViewController controller;
  var loadingPercentage = 0;
  var isFullContentClicked = false;

  @override
  void initState() {
    super.initState();
    initWebViewController();
  }

  void initWebViewController() {
    controller = WebViewController()
      ..setNavigationDelegate(NavigationDelegate(
        onPageStarted: (url) {
          setState(() {
            loadingPercentage = 0;
          });
        },
        onProgress: (progress) {
          setState(() {
            loadingPercentage = progress;
          });
        },
        onPageFinished: (url) {
          setState(() {
            loadingPercentage = 100;
          });
        },
      ))
      ..loadRequest(
        Uri.parse(widget.article.url!),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NewsAppbar(
        isArticleTapped: true,
        actions: widget.article.url != null
            ? [
                IconButton(
                  onPressed: () => _launchURL(widget.article.url!),
                  icon: const Icon(Icons.link_outlined),
                )
              ]
            : [],
      ),
      body: isFullContentClicked
          ? Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IgnorePointer(
                    ignoring: loadingPercentage < 100,
                    child: WebViewWidget(
                      controller: controller,
                    ),
                  ),
                ),
                if (loadingPercentage < 100)
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(
                      child: SpinKitFadingCircle(
                        color: Colors.blue,
                      ),
                    ),
                  )
              ],
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  // Image
                  widget.article.urlToImage != null
                      ? Image.network(widget.article.urlToImage!)
                      : Image.asset(
                          'assets/images/Image_not_available_icon.png'),

                  // Title
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.article.title,
                      style: const TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),

                  // Author + publishedAt
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      RowInfo(
                          icon: Icons.person,
                          value: widget.article.author ?? 'No Available'),
                      RowInfo(
                          icon: Icons.date_range,
                          value: DateFormat.yMMMMd('en_US')
                              .format(widget.article.publishedAt!)),
                    ],
                  ),

                  const Divider(),

                  // Content
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Text(
                          widget.article.content.length >= 200
                              ? widget.article.content.substring(0, 200)
                              : widget.article.content,
                        ),
                        const SizedBox(height: 3),
                        InkWell(
                          onTap: () {
                            setState(() {
                              isFullContentClicked = true;
                            });
                          },
                          child: const Text(
                            'Click here to read more',
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  void _launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }
}
