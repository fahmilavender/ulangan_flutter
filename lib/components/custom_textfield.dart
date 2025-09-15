import 'package:flutter/material.dart';
import 'package:ulangan_flutter/components/customcolors.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.label,
    required this.controller,
    this.isPassword = false,
    this.showToggle = false,
    this.onToggle,
    this.validator,
    this.labelColor,
    this.textColor,
    this.fillColor,
    this.borderColor,
    this.focusedBorderColor,
  });

  final String label;
  final TextEditingController controller;
  final bool isPassword;
  final bool showToggle;
  final VoidCallback? onToggle;
  final String? Function(String?)? validator;

  // Warna kustom opsional
  final Color? labelColor;
  final Color? textColor;
  final Color? fillColor;
  final Color? borderColor;
  final Color? focusedBorderColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: SizedBox(
        height: 64,
        child: TextFormField(
          controller: controller,
          obscureText: isPassword,
          validator: validator,
          style: TextStyle(
            color: textColor ?? Customcolors.textPrimary,
            fontSize: 15,
            fontWeight: FontWeight.w400,
          ),
          decoration: InputDecoration(
            labelText: label,
            labelStyle: TextStyle(
              color: labelColor ?? Customcolors.textFieldLabel,
              fontSize: 15,
              fontWeight: FontWeight.w400,
            ),
            filled: true,
            fillColor: fillColor ?? Customcolors.textFieldFill,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 0,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: borderColor ?? Customcolors.textFieldBorder,
                width: 1,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: borderColor ?? Customcolors.textFieldBorder,
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: focusedBorderColor ?? Customcolors.primary,
                width: 1.5,
              ),
            ),
            suffixIcon: showToggle
                ? IconButton(
                    icon: Icon(
                      isPassword ? Icons.visibility_off : Icons.visibility,
                      color: Customcolors.grey600,
                      size: 20,
                    ),
                    onPressed: onToggle,
                  )
                : null,
          ),
        ),
      ),
    );
  }
}
