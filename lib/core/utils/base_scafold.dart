import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rsa_showroom/controllers/network_provider.dart';


class BaseScaffold extends StatelessWidget {
  final Widget child;
  const BaseScaffold({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final isOnline = context.watch<NetworkProvider>().isOnline;

    return Scaffold(
      body: Stack(
        children: [
          child,
          if (!isOnline)
            Center(
              child: const Text(
                "No Internet Connection",
                style: TextStyle(color: Colors.red, fontSize: 16,fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
        ],
      ),
    );
  }
}
