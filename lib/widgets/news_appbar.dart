import 'package:flutter/material.dart';

class NewsAppbar extends StatelessWidget implements PreferredSizeWidget {
  final bool isArticleTapped;
  final List<Widget>? actions;

  const NewsAppbar({
    super.key,
    required this.isArticleTapped,
    required this.actions,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('News'),
      actions: actions,
    );
  }
}
