import 'package:flutter/material.dart';
import 'package:rsa_showroom/views/add_bookings.dart';
import 'package:rsa_showroom/views/bottom_nav/home_screen.dart';
import 'package:rsa_showroom/views/sign_in.dart';
import 'package:rsa_showroom/views/signup_screen.dart';

class Routes {
  static final Map<String, WidgetBuilder> routes = {
    '/signIn': (context) => SignIn(),
    '/signUp': (context) => SignUpScreen(),
    '/home': (context) => HomeScreen(),
    '/addBookings': (context) => AddBookings(),
  };
}
