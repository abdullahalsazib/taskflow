import 'package:flutter/material.dart';
import 'package:task_flow/features/tasks/presentation/providers/todo_provider.dart';
import 'package:provider/provider.dart';
import 'package:task_flow/core/theme/app_color.dart';

class BuildStatistics extends StatelessWidget {
  const BuildStatistics({super.key});
  @override
  Widget build(BuildContext context) {
    final todoProvider = context.watch<TodoProvider>();

    return Row(
      children: [
        _buildStatCard(
          context: context,
          icon: Icons.grid_view_rounded,
          iconColor: AppColors.brandPrimary,
          number: todoProvider.totalTasks.toString(),
          title: "Total",
        ),

        const SizedBox(width: 10),

        _buildStatCard(
          context: context,
          icon: Icons.pending_actions_rounded,
          iconColor: AppColors.warning,
          number: todoProvider.pendingTasks.toString(),
          title: "Pending",
        ),

        const SizedBox(width: 10),

        _buildStatCard(
          context: context,
          icon: Icons.check_circle_outline_rounded,
          iconColor: AppColors.success,
          number: todoProvider.completedTasks.toString(),
          title: "Done",
        ),
      ],
    );
  }
}

Widget _buildStatCard({
  required BuildContext context,
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: iconColor, size: 21),

          const SizedBox(height: 4),

          Text(
            number,
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w800,
              color: AppColors.textPrimary(context),
            ),
          ),

          Text(
            title,
            style: TextStyle(fontSize: 11, color: AppColors.textMuted(context)),
          ),
        ],
      ),
    ),
  );
}
