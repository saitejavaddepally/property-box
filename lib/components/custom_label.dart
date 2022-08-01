import 'package:flutter/material.dart';

class CustomLabel extends StatelessWidget {
  final String text;
  const CustomLabel({required this.text, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: const TextStyle(
            fontWeight: FontWeight.w400, fontSize: 16, letterSpacing: -0.15));
  }
}
