import 'package:flutter/material.dart';

class CustomDropdown extends StatelessWidget {
  final List<DropdownItem> items;
  final String? value;
  final void Function(String?)? onChanged;
  final String hintText;

  const CustomDropdown({
    super.key,
    required this.items,
    required this.value,
    required this.onChanged,
    this.hintText = "Pilih item",
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: value,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      ),
      hint: Text(hintText),
      items: items
          .map((e) => DropdownMenuItem(
                value: e.value,
                child: Row(
                  children: [
                    Icon(Icons.circle, size: 12, color: e.color),
                    const SizedBox(width: 6),
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

  DropdownItem({
    required this.value,
    required this.label,
    required this.color,
  });
}
