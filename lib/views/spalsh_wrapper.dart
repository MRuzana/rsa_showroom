import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SplashWrapper extends StatefulWidget {
  const SplashWrapper({super.key});

  @override
  State<SplashWrapper> createState() => _SplashWrapperState();
}

class _SplashWrapperState extends State<SplashWrapper> {

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    await Future.delayed(const Duration(seconds: 2)); // splash time

    final prefs = await SharedPreferences.getInstance();
    final bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    if (!mounted) return;

    if (isLoggedIn) {
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      Navigator.pushReplacementNamed(context, '/signIn');
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image(
          image: AssetImage('assets/images/logo.png'),
        ),
      ),
    );
  }
}



// Future<void> initDeepLink(BuildContext context) async {
//   final Uri? uri = await getInitialUri();

//   if (uri != null) {
//     print("Deep link opened: $uri");

//     final id = uri.queryParameters['id'];
//     final name = uri.queryParameters['name'];
//     final location = uri.queryParameters['location'];
//     final phone = uri.queryParameters['phone'];

//     // Navigate based on deep link
//     Navigator.pushReplacementNamed(
//       context,
//       '/signIn',
//       arguments: {
//         'id': id,
//         'name': name,
//         'location': location,
//         'phone': phone,
//       },
//     );
//   }
// }