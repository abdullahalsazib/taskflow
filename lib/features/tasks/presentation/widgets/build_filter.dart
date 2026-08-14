import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_flow/core/theme/app_color.dart';
import 'package:task_flow/features/tasks/presentation/providers/todo_provider.dart';

class BuildFilter extends StatelessWidget {
  const BuildFilter({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> filters = ["All", "Low", "Medium", "High"];

    // Read current filter from provider
    final selectedFilter = context.watch<TodoProvider>().filterPriority;

    return Row(
      children: List.generate(filters.length, (index) {
        final filter = filters[index];

        // Check if current button is selected
        final selected = selectedFilter == filter;

        return Expanded(
          child: GestureDetector(
            onTap: () {
              // Update the filter in provider
              context.read<TodoProvider>().updateFilter(filter);
            },
            child: Container(
              margin: EdgeInsets.only(
                right: index == filters.length - 1 ? 0 : 8,
              ),
              padding: const EdgeInsets.symmetric(vertical: 9),
              decoration: BoxDecoration(
                color: selected
                    ? Theme.of(context).colorScheme.primary
                    : AppColors.softSurface(context),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Text(
                  filter,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: selected
                        ? Colors.white
                        : AppColors.textSecondary(context),
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
