import 'package:flutter/material.dart';

class TextFieldBuilder extends StatelessWidget {
  const TextFieldBuilder({
    Key? key,
    required this.controller,
    required this.onChanged,
    required this.labelText,
  }) : super(key: key);

  final TextEditingController controller;
  final void Function(String) onChanged;
  final String labelText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: true,
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        labelText: labelText,
      ),
      onChanged: onChanged,
    );
  }
}
