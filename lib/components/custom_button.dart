import 'package:flutter/material.dart';
import 'package:ulangan_flutter/components/customcolors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.myText,
    this.onPressed,
    this.myTextColor,
    this.backgroundColor,
    this.isLoading = false,
  });

  final String? myText;
  final Color? myTextColor;       // bisa dikustom dari halaman
  final Color? backgroundColor;   // bisa dikustom dari halaman
  final VoidCallback? onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final Color finalTextColor = myTextColor ?? Customcolors.background;
    final Color finalBackgroundColor = backgroundColor ?? Customcolors.buttonlogin;

    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: finalBackgroundColor,
          elevation: 4,
          shadowColor: finalBackgroundColor.withOpacity(0.4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20),
        ),
        child: isLoading
            ? SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                  color: finalTextColor,
                  strokeWidth: 2.5,
                ),
              )
            : Text(
                myText ?? "",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: finalTextColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
              ),
      ),
    );
  }
}

