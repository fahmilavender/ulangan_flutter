import 'package:flutter/material.dart';
import 'package:ulangan_flutter/components/customcolors.dart';

class CustomDropdown extends StatelessWidget {
  final List<DropdownItem> items;
  final String? value;
  final void Function(String?)? onChanged;
  final String hintText;
  final Color fillColor;

  const CustomDropdown({
    super.key,
    required this.items,
    required this.value,
    required this.onChanged,
    this.hintText = "Pilih item",
    this.fillColor = Customcolors.textFieldFill,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: value,
      decoration: InputDecoration(
        filled: true,
        fillColor: fillColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide( 
            color: Customcolors.textFieldBorder,
            width: 1.5,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: Customcolors.textFieldBorder,
            width: 1.5,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: Customcolors.textFieldBorder,
            width: 1,
          ),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
      dropdownColor: fillColor,
      hint: Text(hintText),
      items: items
          .map((e) => DropdownMenuItem(
                value: e.value,
                child: Row(
                  children: [
                    Icon(
                      e.icon,
                      size: 18,
                      color: e.color,
                    ),
                    const SizedBox(width: 8),
                    Text(e.label),
                  ],
                ),
              ))
          .toList(),
      onChanged: onChanged,
    );
  }
}

class DropdownItem {
  final String value;
  final String label;
  final Color color;
  final IconData icon;

  DropdownItem({
    required this.value,
    required this.label,
    required this.color,
    required this.icon,
  });
}
