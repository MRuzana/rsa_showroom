import 'package:flutter/material.dart';
import 'package:rsa_showroom/core/constants/spacing_constants.dart';


Widget customHeader(String title, BuildContext context) {
  return SizedBox(
    height: 80,
    width: double.infinity,
    child: Stack(
      alignment: Alignment.center,
      children: [
        // Back icon on left
        Positioned(
          left: 0,
          child: GestureDetector(
            onTap: () {
              Navigator.pushReplacementNamed(context, '/home');
            },
            child: const Icon(Icons.arrow_back),
          ),
        ),

        // Center logo + title
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/images/logo.png',
              height: 80,
              fit: BoxFit.contain,
            ),
            kWidth5,
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}