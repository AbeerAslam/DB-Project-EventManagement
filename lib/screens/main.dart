import 'package:event_management/models/gloss_button.dart';
import 'package:event_management/screens/queries_display.dart';
import 'package:event_management/userPages/Admin/admin_main.dart';
import 'package:event_management/userPages/Attendee/attendee_registered.dart';
import 'package:event_management/userPages/Support/support_main.dart';
import 'package:event_management/userPages/Support/support_marketing.dart';
import 'package:flutter/material.dart';
import 'package:event_management/screens/splashscreen.dart';
import 'package:event_management/screens/options.dart';
import 'package:event_management/models/navigation_bar.dart';
import '../models/query_card.dart';
import '../test.dart';
import '../userPages/Admin/admin_emp.dart';
import '../userPages/Admin/admin_log.dart';
import '../userPages/Attendee/attendee_main.dart';




void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(scaffoldBackgroundColor:  const Color.fromARGB(
          255, 19, 17, 17)),
      home: const Scaffold(
        body: Center(child: SplashScreen()),
      ),
    ),
  );
}
