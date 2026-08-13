import 'package:flutter/material.dart';

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
        gradient: LinearGradient(
          colors: [Color(0xFF6254E7), Color(0xFF27C7DD)],
        ),
      ),
      child: Icon(icon, color: Colors.white, size: 28),
    );
  }
}
