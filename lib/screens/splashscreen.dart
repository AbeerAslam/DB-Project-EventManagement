import 'package:flutter/material.dart';
import 'dart:async';
import 'package:shimmer/shimmer.dart';
import 'options.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();

    // Delay for 2 seconds, then navigate to Options screen
    Future.delayed(const Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Options()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            // This image will be centered on the screen
            Opacity(
              opacity: 0.5,
              child: Image.asset('assets/images/LOGO.png'),
            ),

            // Shimmer effect applied to the centered image
            Shimmer.fromColors(
              period: const Duration(milliseconds: 1500),
              baseColor: const  Color.fromARGB(255, 207, 120, 33),
              highlightColor: const Color(0xffbfbdba),
              child: Opacity(
                opacity: 0.5,
                child: Image.asset('assets/images/LOGO.png'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
