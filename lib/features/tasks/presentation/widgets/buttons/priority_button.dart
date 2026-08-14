import 'package:flutter/material.dart';
import 'package:task_flow/core/theme/app_color.dart';

class PriorityButton extends StatelessWidget {
  // 1. Variable gulo ekhane define korte hobe
  final String title;
  final String selected;
  final VoidCallback onTap;

  const PriorityButton({
    super.key,
    required this.title,
    required this.selected,
    required this.onTap,
  });

  @override
  // 2. Build method shudhu context nibe
  Widget build(BuildContext context) {
    final isSelected = title == selected;

    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.only(right: 6),
          padding: const EdgeInsets.symmetric(vertical: 9),
          decoration: BoxDecoration(
            color: isSelected ? Colors.white.withAlpha(35) : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isSelected ? AppColors.warning : Colors.white38,
            ),
          ),
          child: Center(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
