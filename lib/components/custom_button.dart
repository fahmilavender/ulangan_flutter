import 'package:flutter/material.dart';
import 'package:ulangan_flutter/components/customcolors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.myText,
    this.onPressed,
    this.mytextcolor = Customcolors.background,
    this.backgroundColor = Customcolors.buttonlogin,
    this.isLoading = false,
  });

  final String? myText;
  final Color mytextcolor;
  final Color backgroundColor;
  final VoidCallback? onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          elevation: 4,
          shadowColor: backgroundColor.withOpacity(0.4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20),
        ),
        child: isLoading
            ? const SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                  color: Customcolors.background,
                  strokeWidth: 2.5,
                ),
              )
            : Text(
                myText ?? "",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: mytextcolor,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
              ),
      ),
    );
  }
}
