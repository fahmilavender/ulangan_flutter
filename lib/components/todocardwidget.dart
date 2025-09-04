import 'package:flutter/material.dart';

class Todocardwidget extends StatelessWidget {
  final String title;
  final String? description;
  final bool isDone;
  final VoidCallback? onTap;

  const Todocardwidget({
    super.key,
    required this.title,
    this.description,
    this.isDone = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 3,
      child: ListTile(
        leading: Icon(
          isDone ? Icons.check_circle : Icons.radio_button_unchecked,
          color: isDone ? Colors.green : Colors.grey,
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            decoration: isDone ? TextDecoration.lineThrough : null,
          ),
        ),
        subtitle: description != null ? Text(description!) : null,
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}
