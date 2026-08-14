import 'package:flutter/material.dart';
import 'package:task_flow/features/tasks/presentation/providers/todo_provider.dart';
import 'package:provider/provider.dart';

class BuildStatistics extends StatelessWidget {
  const BuildStatistics({super.key});
  @override
  Widget build(BuildContext context) {
    final todoProvider = context.watch<TodoProvider>();

    return Row(
      children: [
        _buildStatCard(
          icon: Icons.grid_view_rounded,
          iconColor: const Color(0xFF4B4A91),
          number: todoProvider.totalTasks.toString(),
          title: "Total",
        ),

        const SizedBox(width: 10),

        _buildStatCard(
          icon: Icons.pending_actions_rounded,
          iconColor: const Color(0xFFE5A83B),
          number: todoProvider.pendingTasks.toString(),
          title: "Pending",
        ),

        const SizedBox(width: 10),

        _buildStatCard(
          icon: Icons.check_circle_outline_rounded,
          iconColor: const Color(0xFF40B88B),
          number: todoProvider.completedTasks.toString(),
          title: "Done",
        ),
      ],
    );
  }
}

Widget _buildStatCard({
  required IconData icon,
  required Color iconColor,
  required String number,
  required String title,
}) {
  return Expanded(
    child: Container(
      height: 88,
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(8),
            blurRadius: 12,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: iconColor, size: 21),

          const SizedBox(height: 4),

          Text(
            number,
            style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w800),
          ),

          Text(
            title,
            style: const TextStyle(fontSize: 11, color: Color(0xFF92909B)),
          ),
        ],
      ),
    ),
  );
}
