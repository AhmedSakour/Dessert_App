import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      required this.hint,
      required this.prefixIcon,
      required this.textInputType,
      this.obscureText = false,
      required this.textEditingController});
  final String hint;
  final Icon prefixIcon;
  final TextInputType textInputType;
  final TextEditingController textEditingController;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(fontFamily: 'poppins'),
      cursorColor: Theme.of(context).colorScheme.primary,
      controller: textEditingController,
      obscureText: obscureText,
      validator: (value) {
        if (value!.isEmpty) {
          return 'field is required';
        }
        return null;
      },
      keyboardType: textInputType,
      decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: Theme.of(context).colorScheme.primary),
              borderRadius: BorderRadius.circular(10)),
          hintText: hint,
          hintStyle: TextStyle(fontFamily: 'poppins'),
          prefixIcon: prefixIcon),
    );
  }
}
