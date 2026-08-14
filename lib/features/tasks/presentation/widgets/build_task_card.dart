import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_flow/core/theme/app_color.dart';
import 'package:task_flow/features/tasks/presentation/providers/todo_provider.dart';
import 'package:task_flow/features/tasks/presentation/widgets/build_priority.dart';
import 'package:task_flow/features/tasks/presentation/widgets/dialogs/delete_dialog.dart';

class BuildTaskCard extends StatelessWidget {
  final String id;
  final String title;
  final String description;
  final String priority;
  final bool completed;

  const BuildTaskCard({
    super.key,
    required this.id,
    required this.title,
    required this.description,
    required this.priority,
    required this.completed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: AppColors.card(context),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow(context),
            blurRadius: 12,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Checkbox
          GestureDetector(
            onTap: () {
              // Toggle task completion status
              context.read<TodoProvider>().toggleTodoStatus(id);
            },
            child: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: completed ? AppColors.success : Colors.transparent,
                border: Border.all(
                  color: completed
                      ? AppColors.success
                      : AppColors.border(context),
                  width: 1.5,
                ),
              ),
              child: completed
                  ? const Icon(Icons.check, color: Colors.white, size: 15)
                  : null,
            ),
          ),

          const SizedBox(width: 12),

          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary(context),
                    decoration: completed ? TextDecoration.lineThrough : null,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 11,
                    height: 1.4,
                    color: AppColors.textMuted(context),
                  ),
                ),

                const SizedBox(height: 9),

                buildPriority(priority),
              ],
            ),
          ),

          const SizedBox(width: 8),

          // Delete action
          IconButton(
            onPressed: () {
              showDeleteDialog(
                context: context,
                taskTitle: title,
                onConfirm: () {
                  // Delete task
                  context.read<TodoProvider>().deleteTodo(id);
                },
              );
            },
            icon: Icon(
              Icons.delete_outline_rounded,
              color: AppColors.textSecondary(context),
            ),
          ),
        ],
      ),
    );
  }
}
