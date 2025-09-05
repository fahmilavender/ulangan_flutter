import 'package:flutter/material.dart';

class OnboardingContent extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color bgColor; // 🔥 tambahin background color

  const OnboardingContent({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.bgColor = Colors.white, // default putih
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: bgColor, // 🔥 apply background color
      padding: const EdgeInsets.all(30),
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 120, color: const Color(0xFF24A19C)),
          const SizedBox(height: 40),
          Text(
            title,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Text(
            subtitle,
            style: const TextStyle(fontSize: 16, color: Colors.black54),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
