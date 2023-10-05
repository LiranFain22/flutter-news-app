import 'package:flutter/material.dart';

class RowInfo extends StatelessWidget {
  final IconData? icon;
  final String value;

  const RowInfo({
    super.key,
    required this.icon,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
        children: [
          const SizedBox(width: 10),
          Icon(icon),
          const SizedBox(width: 5),
          Expanded(
            child: Text(
              value,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ],
    );
  }
}
