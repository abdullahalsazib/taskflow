import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:my_app/features/tasks/data/models/todo_model.dart';
import 'package:my_app/features/tasks/presentation/providers/todo_provider.dart';
import 'package:my_app/features/tasks/presentation/widgets/buttons/priority_button.dart';
import 'package:my_app/features/tasks/presentation/widgets/buttons/dialog_icon.dart';

void showCreateTaskDialog(BuildContext context) {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  String priority = "Medium";

  showDialog(
    context: context,
    barrierColor: Colors.black45,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return Dialog(
            backgroundColor: Colors.transparent,
            insetPadding: const EdgeInsets.symmetric(horizontal: 22),
            child: Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF6254E7), Color(0xFF27C7DD)],
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: DialogIcon(icon: Icons.dashboard_customize_rounded),
                  ),

                  const SizedBox(height: 12),

                  const Center(
                    child: Text(
                      "Create New Task",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    "Title",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  TextField(
                    controller: titleController,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      hintText: "Enter task title",
                      hintStyle: TextStyle(color: Colors.white60),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white54),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  const Text(
                    "Description",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  TextField(
                    controller: descriptionController,
                    maxLines: 2,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      hintText: "Describe your task",
                      hintStyle: TextStyle(color: Colors.white60),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white54),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                  ),

                  const SizedBox(height: 18),

                  const Text(
                    "Priority",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Row(
                    children: [
                      PriorityButton(
                        title: "Low",
                        selected: priority,
                        onTap: () {
                          setState(() {
                            priority = "Low";
                          });
                        },
                      ),

                      PriorityButton(
                        title: "Medium",
                        selected: priority,
                        onTap: () {
                          setState(() {
                            priority = "Medium";
                          });
                        },
                      ),

                      PriorityButton(
                        title: "High",
                        selected: priority,
                        onTap: () {
                          setState(() {
                            priority = "High";
                          });
                        },
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.white,
                            side: const BorderSide(color: Colors.white70),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text("Cancel"),
                        ),
                      ),

                      const SizedBox(width: 8),

                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            final title = titleController.text.trim();
                            // Get description text
                            final description = descriptionController.text
                                .trim();

                            if (title.isEmpty) {
                              return; // Do nothing if title is empty
                            }

                            // Create a new TodoModel
                            final newTask = TodoModel(
                              id: DateTime.now().millisecondsSinceEpoch
                                  .toString(), // Generate unique ID based on current time
                              title: title,
                              description: description,
                              priority: priority,
                            );

                            // Add the new task to the provider
                            context.read<TodoProvider>().addTodo(newTask);

                            Navigator.pop(context); // Close the dialog
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white.withAlpha(35),
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text("Create Task"),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}
