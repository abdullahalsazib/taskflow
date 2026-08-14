import 'package:flutter/material.dart';
import 'package:task_flow/features/tasks/presentation/providers/todo_provider.dart';
import 'package:provider/provider.dart';
import 'package:task_flow/core/theme/app_color.dart';

class BuildSearch extends StatelessWidget {
  const BuildSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: AppColors.softSurface(context),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        style: TextStyle(color: AppColors.textPrimary(context)),
        onChanged: (value) {
          context.read<TodoProvider>().updateSearchQuery(value);
        },
        decoration: InputDecoration(
          hintText: "Search tasks...",
          hintStyle: TextStyle(
            color: AppColors.textMuted(context),
            fontSize: 14,
          ),
          prefixIcon: Icon(
            Icons.search_rounded,
            color: AppColors.textSecondary(context),
            size: 22,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 14),
        ),
      ),
    );
  }
}
