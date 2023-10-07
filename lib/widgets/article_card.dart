import 'package:flutter/material.dart';
import 'package:news_app/widgets/row_info.dart';

import '../models/article.dart';
import '../pages/details_page.dart';

class ArticleCard extends StatelessWidget {
  final Article article;

  const ArticleCard({
    super.key,
    required this.article,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => DetailsPage(
            article: article,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                // image
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: SizedBox(
                    height: 100,
                    width: 150,
                    child: article.urlToImage != null
                        ? Image.network(
                            article.urlToImage!,
                            fit: BoxFit.fill,
                          )
                        : Image.asset(
                            'assets/images/Image_not_available_icon.png',
                            fit: BoxFit.fill,
                          ),
                  ),
                ),

                const SizedBox(width: 5),

                Expanded(
                  child: Column(
                    children: [
                      // Title
                      Text(
                        article.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      const SizedBox(height: 5),
                      
                      // Author
                      article.author != null
                          ? RowInfo(icon: Icons.person, value: article.author!)
                          : const SizedBox.shrink(),

                      const SizedBox(height: 5),

                      // Description
                      Text(
                        article.description ?? '',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
