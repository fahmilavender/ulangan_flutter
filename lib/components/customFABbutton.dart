import 'package:flutter/material.dart';
import 'package:ulangan_flutter/components/customcolors.dart';

class CustomFabButton extends StatelessWidget {
  const CustomFabButton({
    super.key,
    required this.onPressed,
    this.backgroundColor = Customcolors.buttonlogin,
    this.icon = Icons.add,
    this.iconColor = Customcolors.background,
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
