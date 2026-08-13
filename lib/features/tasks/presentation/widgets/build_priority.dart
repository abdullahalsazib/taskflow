import 'package:flutter/material.dart';

Widget buildPriority(String priority) {
  Color background;
  Color foreground;
  IconData icon;

  // Convert to lowercase for case-insensitive matching
  switch (priority.toLowerCase()) {
    case "high":
      background = const Color(0xFFFFE7EF);
      foreground = const Color(0xFFE86D96);
      icon = Icons.arrow_upward_rounded;
      break;

    case "medium":
      background = const Color(0xFFFFF0D8);
      foreground = const Color(0xFFE5A83B);
      icon = Icons.remove_rounded;
      break;

    default: // "low" or any other value
      background = const Color(0xFFE2F8EF);
      foreground = const Color(0xFF37B982);
      icon = Icons.arrow_downward_rounded;
  }

  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    decoration: BoxDecoration(
      color: background,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 11, color: foreground),
        const SizedBox(width: 2),
        Text(
          priority.toLowerCase(),
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w700,
            color: foreground,
          ),
        ),
      ],
    ),
  );
}
