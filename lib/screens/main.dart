import 'package:flutter/material.dart';
import 'package:event_management/screens/splashscreen.dart';
import 'package:event_management/screens/layout.dart';


void main() {
  runApp(
    const MaterialApp(
      home: Scaffold(
        body: Center(child: Layout() ),
      ),
    ),
  );
}

