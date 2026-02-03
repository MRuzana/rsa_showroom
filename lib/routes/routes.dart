import 'package:flutter/material.dart';
import 'package:rsa_showroom/models/showroon_staff_model.dart';
import 'package:rsa_showroom/views/add_bookings.dart';
import 'package:rsa_showroom/views/bottom_nav/account_screen.dart';
import 'package:rsa_showroom/views/bottom_nav/home_screen.dart';
import 'package:rsa_showroom/views/ongoing.dart';
import 'package:rsa_showroom/views/reward.dart';
import 'package:rsa_showroom/views/sign_in.dart';
import 'package:rsa_showroom/views/signup_screen.dart';

class Routes {
  static final Map<String, WidgetBuilder> routes = {
    '/signIn': (context) => SignIn(),
    '/signUp': (context) => SignUpScreen(),
    '/home': (context) => HomeScreen(),
    '/addBookings': (context) => AddBookings(),
    '/onGoing' :(context) => OnGoing(),
    '/reward' :(context) => Rewards(),
    '/account': (context) {
      final staff = ModalRoute.of(context)!.settings.arguments as ShowroomStaffModel;
      return AccountScreen(staff: staff);
    }
    
  };
}
