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
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onPressed,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child: Icon(
          icon,
          color: iconColor,
        ),
      ),
    );
  }
}
