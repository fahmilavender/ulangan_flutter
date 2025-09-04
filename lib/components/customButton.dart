import 'package:flutter/material.dart';

class Custombutton extends StatelessWidget {
  const Custombutton({super.key, required this.mytext, required this.mytextcolor, required this.onPressed});

  final String mytext;
  final Color mytextcolor;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(mytext, style: TextStyle(color: mytextcolor),
    ),);
  }
}