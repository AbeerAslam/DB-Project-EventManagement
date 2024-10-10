import 'package:flutter/material.dart';
import 'package:event_management/screens/options.dart';

import 'dart:async';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Options()),
      );
    });
  }
  @override
  Widget build(context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
    Image.asset(
    'assets/images/CBS_LOGO.jpg',
      width: 200,
    ),
    const SizedBox(height: 20)]
  );
}
}
