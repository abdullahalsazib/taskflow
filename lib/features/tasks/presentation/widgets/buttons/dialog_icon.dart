import 'package:flutter/material.dart';
import 'package:task_flow/core/theme/app_color.dart';

class DialogIcon extends StatelessWidget {
  final IconData icon;

  const DialogIcon({super.key, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 58,
      height: 58,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: AppColors.brandGradient,
      ),
      child: Icon(icon, color: Colors.white, size: 28),
    );
  }
}
