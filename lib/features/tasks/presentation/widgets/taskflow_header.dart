// taskflow_header.dart
import 'package:flutter/material.dart';

class TaskflowHeader extends StatelessWidget {
  // Callback for the settings button so the parent can handle the logic
  final VoidCallback onSettingsPressed;

  const TaskflowHeader({super.key, required this.onSettingsPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: const Color(0xFF62508F),
            borderRadius: BorderRadius.circular(15),
          ),
          child: const Icon(
            Icons.checklist_rounded,
            color: Colors.white,
            size: 27,
          ),
        ),

        const SizedBox(width: 12),

        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "TaskFlow",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF24232B),
                ),
              ),
              SizedBox(height: 2),
              Text(
                "Stay productive, stay organized",
                style: TextStyle(fontSize: 12, color: Color(0xFF9A98A3)),
              ),
            ],
          ),
        ),

        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: const Color(0xFFF3F1F8),
            borderRadius: BorderRadius.circular(14),
          ),
          child: IconButton(
            onPressed: onSettingsPressed, // Use the callback here
            icon: const Icon(Icons.settings_outlined),
          ),
        ),
      ],
    );
  }
}
