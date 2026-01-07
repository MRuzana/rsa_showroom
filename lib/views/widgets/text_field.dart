import 'package:flutter/material.dart';

Widget textField({
  required TextEditingController controller,
  required TextInputType keyboardType,
  required String labelText,
  required String? Function(String?)? validator,
  required AutovalidateMode autovalidateMode,
  required Widget suffixIcon,
  bool isObscured = false,
  int maxLines = 1,
  int minLines = 1
}) {
  return TextFormField(
    controller: controller,
    keyboardType: keyboardType,
    obscureText: isObscured,
    maxLines: maxLines,
    minLines: minLines,
    decoration: InputDecoration(
      border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10 ))),
      labelText: labelText,
      hintStyle: const TextStyle(color: Color(0xFF858080)), // Hint text color
      suffixIcon: suffixIcon,
      suffixIconColor: Color(0x33858080),
    ),
    validator: validator,
    autovalidateMode: autovalidateMode, 
  );
}
