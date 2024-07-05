import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String? Function(String?)? validator;
  final String? title;
  final String? label;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  const CustomTextFormField(
      {super.key,
      this.validator,
      this.label,
      this.title,
      this.onChanged,
      this.keyboardType,
      this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      child: TextFormField(
        onChanged: onChanged,
        keyboardType: keyboardType,
        controller: controller,
        decoration: InputDecoration(
          hintText: title,
          label: Text(label ?? ''),
        ),
        validator: validator,
      ),
    );
  }
}
