import 'package:flutter/material.dart';

class MyTextFieldForm extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obsecureText;
  final FocusNode? focusNode;

  const MyTextFieldForm(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.obsecureText,
      this.focusNode});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obsecureText,
      focusNode: focusNode,
      decoration: InputDecoration(
        labelText: hintText,
        labelStyle: const TextStyle(color: Color(0xFFF84669)),
        hintText: hintText,
        hintStyle: const TextStyle(color: Color(0xFFB9B6B9)),
      ),
    );
  }
}
