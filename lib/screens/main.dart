import 'package:flutter/material.dart';
import 'package:event_management/screens/splashscreen.dart';
import 'package:event_management/screens/options.dart';




void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(scaffoldBackgroundColor:  const Color.fromARGB(
          255, 19, 17, 17)),
      home: const Scaffold(
        body: Center(child: Options() ),
      ),
    ),
  );
}

