// taskflow_header.dart
import 'package:flutter/material.dart';
import 'package:task_flow/core/theme/app_color.dart';

class TaskflowHeader extends StatelessWidget {
  // Callback for the settings button so the parent can handle the logic
  final VoidCallback onSettingsPressed;

  const TaskflowHeader({super.key, required this.onSettingsPressed});

  @override
  Widget build(BuildContext context) {
    final titleColor = AppColors.textPrimary(context);
    final subtitleColor = AppColors.textSecondary(context);

    return Row(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: AppColors.brandPrimary,
            borderRadius: BorderRadius.circular(15),
          ),
          child: const Icon(
            Icons.checklist_rounded,
            color: Colors.white,
            size: 27,
          ),
        ),

        const SizedBox(width: 12),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "TaskFlow",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: titleColor,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                "Stay productive, stay organized",
                style: TextStyle(fontSize: 12, color: subtitleColor),
              ),
            ],
          ),
        ),

        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: AppColors.softSurface(context),
            borderRadius: BorderRadius.circular(14),
          ),
          child: IconButton(
            onPressed: onSettingsPressed, // Use the callback here
            icon: Icon(
              Icons.settings_outlined,
              color: AppColors.textSecondary(context),
            ),
          ),
        ),
      ],
    );
  }
}
