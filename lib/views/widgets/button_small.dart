import 'package:flutter/material.dart';

Widget buttonSmall(
    {required String buttonText,
    required void Function() buttonPressed,
    Color? color,
    double? size}) {
  return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onPressed: buttonPressed,
      child: Text(
        buttonText,
        style: TextStyle(color: Colors.white, fontSize: size,fontWeight: FontWeight.bold),
      ));
}
