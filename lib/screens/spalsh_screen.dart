import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pixabay_machine_test/screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // Go to Home screen after 3s.
    Timer(const Duration(seconds: 3), () {
      Navigator.push(context, MaterialPageRoute(builder: (_) => HomeScreen()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          // image from asset
          child: Image.asset(
            'assets/images/logo.png',
            width: 200.0,
            height: 200.0,
          ),
        ),
      ),
    );
  }
}
