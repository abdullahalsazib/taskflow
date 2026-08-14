import 'package:flutter/material.dart';
import 'package:task_flow/features/tasks/presentation/providers/todo_provider.dart';
import 'package:provider/provider.dart';

class BuildSearch extends StatelessWidget {
  const BuildSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: const Color(0xFFF3F1F8),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        onChanged: (value) {
          context.read<TodoProvider>().updateSearchQuery(value);
        },
        decoration: InputDecoration(
          hintText: "Search tasks...",
          hintStyle: TextStyle(color: Color(0xFF85838D), fontSize: 14),
          prefixIcon: Icon(
            Icons.search_rounded,
            color: Color(0xFF55535D),
            size: 22,
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 14),
        ),
      ),
    );
  }
}
