/*import 'package:event_management/models/gloss_button.dart';
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
      home: Scaffold(
        body: Center(child: SplashScreen()),
      ),
    ),
  );
}*/
import 'package:event_management/screens/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:event_management/userPages/organizer/organizer_main.dart';
import 'package:event_management/userPages/Admin/admin_main.dart';
import 'package:event_management/userPages/Support/support_main.dart';
import 'package:event_management/UserPages/Attendee/attendee_main.dart';
import 'package:event_management/userPages/cordinator/coordinator_main.dart';
import '../models/app_bar.dart';

Future<void> main() async {
  // Load .env file before app starts
  await dotenv.load(fileName: ".env");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Event Management',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark, // Dark theme
        scaffoldBackgroundColor: Colors.black, // Black background
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          iconTheme: IconThemeData(color: Colors.white),
          titleTextStyle: TextStyle(color: Colors.white),
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white),
          labelLarge: TextStyle(color: Colors.white),
        ),
      ),
      home: const SplashScreen(), // Role selection screen
    );
  }
}

class UserRoleSelection extends StatelessWidget {
  const UserRoleSelection({super.key});

  @override
  Widget build(BuildContext context) {
    final apiKey = dotenv.env['API_KEY'] ?? 'No API Key Found';  // Accessing .env values
    final baseUrl = dotenv.env['BASE_URL'] ?? 'No Base URL Found';

    return Scaffold(
      appBar: CustomAppBar(titleText: "Event Management App", false, true).buildAppBar(),
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('API Key: $apiKey', style: const TextStyle(color: Colors.white)),
            Text('Base URL: $baseUrl', style: const TextStyle(color: Colors.white)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const Admin()));
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo),
              child: const Text('Admin'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const OrganizerMain(email:"organizer1@gmail.com")));
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo),
              child: const Text('Organizer'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const CoordinatorHome()));
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo),
              child: const Text('Coordinator'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Attendee(email: 'attendee@gmail.com')),
                );
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo),
              child: const Text('Attendee'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Support(email: 'support@example.com')),
                );
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo),
              child: const Text('Support'),
            ),
          ],
        ),
      ),
    );
  }
}
