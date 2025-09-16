import 'package:flutter/material.dart';
import 'package:ulangan_flutter/components/customcolors.dart';

class CustomFabButton extends StatefulWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final double size;

  const CustomFabButton({
    super.key,
    required this.onPressed,
    this.icon = Icons.add,
    this.size = 65.0, required Color backgroundColor, required Color background,
  });

  @override
  State<CustomFabButton> createState() => _CustomFabButtonState();
}

class _CustomFabButtonState extends State<CustomFabButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    )..forward();
    _scale = CurvedAnimation(parent: _controller, curve: Curves.easeOutBack);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scale,
      child: GestureDetector(
        onTap: widget.onPressed,
        child: Container(
          width: widget.size,
          height: widget.size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Customcolors.bluewidget, // ✅ pakai custom color
            boxShadow: [
              BoxShadow(
                color: Customcolors.bluewidget.withOpacity(0.4),
                blurRadius: 16,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Center(
            child: Icon(
              widget.icon,
              color: Colors.white,
              size: widget.size * 0.45,
            ),
          ),
        ),
      ),
    );
  }
}
