import 'package:flutter/material.dart';

Widget dropdownField<T>({
  required T? value,
  required List<DropdownMenuItem<T>> items,
  required void Function(T?) onChanged,
  required String labelText,
  String? Function(T?)? validator,
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled,
}) {
  return DropdownButtonFormField<T>(
    value: value,
    items: items,
    onChanged: onChanged,
    validator: validator,
    autovalidateMode: autovalidateMode,
    decoration: const InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      hintStyle: TextStyle(color: Color(0xFF858080)),
    ),
  );
}