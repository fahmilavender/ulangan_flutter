import 'package:flutter/material.dart';

class Customtextfield extends StatelessWidget {
  const Customtextfield({super.key, required this.label, required this.controller, required this.password});
  
  final String label;
  final TextEditingController controller;
  final bool password;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        controller: controller,
        obscureText: password,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}