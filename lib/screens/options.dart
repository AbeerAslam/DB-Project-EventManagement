import 'dart:convert';

import 'package:event_management/models/input_password_dialog.dart';
import 'package:event_management/userPages/Attendee/attendee_main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/app_bar.dart';
import '../models/button.dart';

class Options extends StatefulWidget {
  const Options({super.key});

  @override
  State<Options> createState() => _Options();
}

class _Options extends State<Options> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        appBar: CustomAppBar(titleText:'',false,true).buildAppBar(),
        body: SafeArea(
          top: true,
          child: Stack(
            children: [
              Align(
                alignment: const AlignmentDirectional(0, -0.5),
                child: CustomButton(
                  buttonText: 'Admin',
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext dialogContext) {
                        return PasswordDialog(
                          user: 'admin',
                          email: 'admin@gmail.com',
                          onSubmit: (String email, String password) {
                            // Handle password submission
                          },
                        );
                      },
                    );

                  },
                ),
              ),
              Align(
                alignment: const AlignmentDirectional(0, 0),
                child: CustomButton(
                  buttonText: 'Management',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ManagementOptions(),
                      ),
                    );
                  },
                ),
              ),
              Align(
                alignment: const AlignmentDirectional(0, 0.5),
                child: CustomButton(
                  buttonText: 'Attendee',
                  onPressed: () {
                    _showEmailDialog(context);
                   /* Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const EventCategory(),*/
                      //),
                    //);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



class ManagementOptions extends StatelessWidget{
late final String buttonText;
late final VoidCallback onPressed;
final scaffoldKey = GlobalKey<ScaffoldState>();

ManagementOptions({super.key});


@override
Widget build(BuildContext context) {
  return GestureDetector(
    onTap: () => FocusScope.of(context).unfocus(),
    child: Scaffold(
      key: scaffoldKey,
      appBar: CustomAppBar(titleText:'Management',true,true).buildAppBar(),
      body: SafeArea(
        top: true,
        child: Stack(
          children: [
            Align(
              alignment: const AlignmentDirectional(0, -0.5),
              child: CustomButton(
                buttonText: 'Organizer',
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext dialogContext) {
                      return PasswordDialog(
                        user:'organizer',
                        email: 'organizer?@gmail.com',
                        onSubmit: (String email, String password) {
                          // Handle password submission
                        },
                      );
                    },
                  );
                },
              ),
            ),
            Align(
              alignment: const AlignmentDirectional(0, 0),
              child: CustomButton(
                buttonText: 'Coordinator',
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext dialogContext) {
                      return PasswordDialog(
                        user:'coordinator',
                        email: 'coordinator?@gmail.com',
                        onSubmit: (String email, String password) {
                          // Handle password submission
                        },
                      );
                    },
                  );
                  // Navigate to management screen
                },
              ),
            ),
            Align(
              alignment: const AlignmentDirectional(0, 0.5),
              child: CustomButton(
                buttonText: 'Support Specialist',
                onPressed: () {
                  showDialog(
                  context: context,
                  builder: (BuildContext dialogContext) {
                  return PasswordDialog(
                    user:'support',
                    email: 'support?@gmail.com',
                  onSubmit: (String email, String password) {
                  // Handle password submission
                  },
                  );
                  },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
}

void _showEmailDialog(BuildContext context) {
  String attendeeEmail = ''; // Variable to store email

  showDialog(
    context: context,
    builder: (BuildContext dialogContext) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 10,
        backgroundColor: Colors.transparent,
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.topCenter,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.85,
              padding: const EdgeInsets.fromLTRB(20, 60, 20, 20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color.fromARGB(255, 63, 43, 150),
                    Color.fromARGB(255, 97, 67, 218),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Enter Email',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Email',
                      hintStyle: const TextStyle(color: Colors.white70),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.2),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    onChanged: (value) {
                      attendeeEmail = value;
                    },
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(dialogContext).pop(); // Close the dialog
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 24,
                          ),
                          backgroundColor: const Color.fromARGB(255, 255, 165, 0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            ),
                        ),
                        child: const Text(
                          'Cancel',
                          style: TextStyle(color: Colors.white70),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          // Close the dialog first
                          Navigator.of(dialogContext).pop();

                          // Navigate to EventCategory screen immediately
                          Navigator.push(
                            context, // Use the parent context for navigation
                            MaterialPageRoute(
                              builder: (context) => Attendee(email: attendeeEmail),
                            ),
                          );

                          // Optionally, you can still call the backend for logging purposes or other needs
                          await handleAttendeeEmail(attendeeEmail);
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 24,
                          ),
                          backgroundColor: const Color.fromARGB(255, 255, 165, 0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'OK',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              top: -40,
              child: CircleAvatar(
                radius: 40,
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.email_outlined,
                  size: 40,
                  color: Colors.deepPurple.shade700,
                ),
              ),
            ),
          ],
        ),
      );
    },
  );

}


Future<bool> handleAttendeeEmail(String email) async {
  const String apiUrl = 'http://10.0.2.2:3000/api/attendee/activity'; // Replace with your backend URL

  try {
    final response = await http.post(Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'email': email}),
    );

    if (response.statusCode == 200) {
      // Successfully checked or added attendee
      if (kDebugMode) {
        print('Backend Response: ${response.body}');
      }
      return true;
    } else {
      // Handle failure cases
      if (kDebugMode) {
        print(' ${response.body}');
      }
      return false;
    }
  } catch (e) {
    if (kDebugMode) {
      print('Error connecting to backend: $e');
    }
    return false;
  }
}

