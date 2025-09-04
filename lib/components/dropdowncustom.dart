import 'package:flutter/material.dart';

class Dropdowncustom extends StatelessWidget {
  final List<String> items;
  final String? value;
  final void Function(String?) onChanged;
  final String hintText;

  const Dropdowncustom({
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
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      ),
      hint: Text(hintText),
      items: items
          .map((e) => DropdownMenuItem(
                value: e,
                child: Text(e),
              ))
          .toList(),
      onChanged: onChanged,
    );
  }
}
