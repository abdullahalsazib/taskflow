import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(7),
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
                color: completed ? const Color(0xFF36C985) : Colors.transparent,
                border: Border.all(
                  color: completed
                      ? const Color(0xFF36C985)
                      : const Color(0xFFD1CFD6),
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
                    color: const Color(0xFF29272F),
                    decoration: completed ? TextDecoration.lineThrough : null,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 11,
                    height: 1.4,
                    color: Color(0xFF92909A),
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
            icon: const Icon(Icons.delete_outline_rounded),
          ),
        ],
      ),
    );
  }
}
