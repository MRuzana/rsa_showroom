import 'package:flutter/material.dart';

Widget button({
  required String buttonText,
  required void Function() buttonPressed,
  Color? color,
  double? size
}) {
  return SizedBox(
    width: double.infinity,
    height: 50 ,
    child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
        ),
        onPressed: buttonPressed,
        child: Text(
          buttonText,
          style: TextStyle(color: Colors.white,fontSize: size),
        )),
  );
}