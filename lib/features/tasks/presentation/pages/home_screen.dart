import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:my_app/features/tasks/presentation/providers/todo_provider.dart';
import 'package:my_app/features/tasks/presentation/widgets/dialogs/setting_dialog.dart';
import 'package:my_app/features/tasks/presentation/widgets/taskflow_header.dart';
import 'package:my_app/features/tasks/presentation/widgets/build_filter.dart';
import 'package:my_app/features/tasks/presentation/widgets/build_search.dart';
import 'package:my_app/features/tasks/presentation/widgets/build_statistics.dart';
import 'package:my_app/features/tasks/presentation/widgets/build_task_card.dart';
import 'package:my_app/features/tasks/presentation/widgets/dialogs/create_task_dialog.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TodoProvider>();
    final tasks = provider.filteredTodos;

    return Scaffold(
      backgroundColor: const Color(0xFFFDFBFF),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            children: [
              const SizedBox(height: 16),

              // Header
              TaskflowHeader(
                onSettingsPressed: () => showSettingsDialog(context),
              ),

              const SizedBox(height: 22),

              // Statistics
              const BuildStatistics(),

              const SizedBox(height: 20),

              // Search
              const BuildSearch(),

              const SizedBox(height: 16),

              // Filters
              const BuildFilter(),

              const SizedBox(height: 18),

              // Tasks
              Expanded(
                child: tasks.isEmpty
                    ? const Center(
                        child: Text(
                          "No tasks found!",
                          style: TextStyle(
                            color: Color(0xFF85838D),
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      )
                    : ListView.separated(
                        padding: const EdgeInsets.only(bottom: 90),
                        itemCount: tasks.length,
                        separatorBuilder: (_, _) => const SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          final task = tasks[index];

                          return BuildTaskCard(
                            id: task.id,
                            title: task.title,
                            description: task.description,
                            priority: task.priority,
                            completed: task.isCompleted,
                            // Pass task.id to handle delete and toggle actions in the provider
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),

      // Add Task
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showCreateTaskDialog(context);
        },
        backgroundColor: const Color(0xFF4B4B94),
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text("Add Task", style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
