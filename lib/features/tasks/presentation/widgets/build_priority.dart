import 'package:flutter/material.dart';
import 'package:task_flow/core/theme/app_color.dart';

Widget buildPriority(String priority) {
  Color background;
  Color foreground;
  IconData icon;

  // Convert to lowercase for case-insensitive matching
  switch (priority.toLowerCase()) {
    case "high":
      background = AppColors.priorityHighBackground;
      foreground = AppColors.priorityHighForeground;
      icon = Icons.arrow_upward_rounded;
      break;

    case "medium":
      background = AppColors.priorityMediumBackground;
      foreground = AppColors.priorityMediumForeground;
      icon = Icons.remove_rounded;
      break;

    default: // "low" or any other value
      background = AppColors.priorityLowBackground;
      foreground = AppColors.priorityLowForeground;
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
