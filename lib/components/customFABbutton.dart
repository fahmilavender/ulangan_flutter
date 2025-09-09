import 'package:flutter/material.dart';

class CustomFabButton extends StatelessWidget {
  const CustomFabButton({
    super.key,
    required this.onPressed,
    this.backgroundColor = const Color(0xFF24A19C),
    this.icon = Icons.add,
    this.iconColor = Colors.white,
    this.size = 56.0,
  });

  final VoidCallback onPressed;
  final Color backgroundColor;
  final IconData icon;
  final Color iconColor;
  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: const CircleBorder(),
          padding: EdgeInsets.zero,
          elevation: 4,
        ),
        child: Icon(icon, color: iconColor),
      ),
    );
  }
}
