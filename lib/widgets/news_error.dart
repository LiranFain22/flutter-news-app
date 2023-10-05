import 'package:flutter/material.dart';
import 'package:news_app/models/error.dart';

class NewsErrorWidget extends StatelessWidget {
  final NewsError error;

  const NewsErrorWidget({
    super.key,
    required this.error,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 30),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: SizedBox(
            width: 100,
            height: 100,
            child: Image.asset(
              'assets/images/not_found_icon.png',
            ),
          ),
        ),
        const SizedBox(height: 30),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: Text(
              error.code,
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Text(
              error.message,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
