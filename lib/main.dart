import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rsa_showroom/controllers/booking_provider.dart';
import 'package:rsa_showroom/controllers/bottom_nav_provider.dart';
import 'package:rsa_showroom/controllers/location_provider.dart';
import 'package:rsa_showroom/controllers/network_provider.dart';
import 'package:rsa_showroom/core/themes/app_theme.dart';
import 'package:rsa_showroom/routes/routes.dart';
import 'package:rsa_showroom/views/spalsh_wrapper.dart';

void main() async {

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => BottomNavProvider()),
        ChangeNotifierProvider(create: (context) => LocationProvider()),
        ChangeNotifierProvider(create: (context) => NetworkProvider()),
        ChangeNotifierProvider(create: (context) => BookingListProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.appTheme,
        themeMode: ThemeMode.system,
        initialRoute: '/',
        routes: Routes.routes,
        home: const SplashWrapper(),
      ),
    );
  }
}