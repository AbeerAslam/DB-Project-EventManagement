import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:vibration/vibration.dart';
import 'dart:convert';

import '../userPages/Admin/admin_main.dart';

class PasswordDialog extends StatelessWidget {
  final String user;
  final String email; // Existing email property
  final Function(String, String) onSubmit; // Callback now accepts email and password
  const PasswordDialog({
    required this.email,
    required this.user,
    required this.onSubmit,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Controllers for the text fields
    TextEditingController emailController = TextEditingController(text: email); // Controller for email (pre-filled)
    TextEditingController passwordController = TextEditingController(); // Controller for the password field

    return AlertDialog(
      title: const Text('Login'),
      content: Column(
        mainAxisSize: MainAxisSize.min, // Ensure the dialog is compact
        children: <Widget>[
          // Email input field
          TextField(
            controller: emailController, // Use the controller for the email field
            decoration: const InputDecoration(hintText: "Enter your email"),
          ),
          const SizedBox(height: 10), // Add space between the fields
          // Password input field
          TextField(
            controller: passwordController, // Use the controller for the password field
            decoration: const InputDecoration(hintText: "Enter your password"),
            obscureText: true, // Mask the password input
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: const Text('Submit'),
          onPressed: () async {
            String inputEmail = emailController.text; // Capture email input
            String inputPassword = passwordController.text; // Capture password input
            if (kDebugMode) {
              print('Input Email: $inputEmail');
              print('Input Password: $inputPassword');
            }

            try {
              // Call the API to verify email and password
              final response = await http.post(
                Uri.parse('http://10.0.2.2:3000/api/verify-password'), // Your backend URL
                headers: {'Content-Type': 'application/json'},
                body: json.encode({'email': inputEmail, 'password': inputPassword}),
              );

              if (kDebugMode) {
                print('Response Status: ${response.statusCode}');
                print('Response Body: ${response.body}');
              }

              if (response.statusCode == 200) {
                // Password is correct
                onSubmit(inputEmail, inputPassword); // Call the onSubmit callback with both email and password
                // Add navigation here
                if(user=='admin'){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  const Admin()), // Replace NextScreen with your actual screen
                  );
                }
              } else if (response.statusCode == 401) {
                // Invalid password
                if (await Vibration.hasVibrator() == true) { // Ensure hasVibrator is true
                  Vibration.vibrate(duration: 1000);
                }

              } else {
                // Other errors
                if (kDebugMode) {
                  print('Error: ${response.body}');
                }
              }
            } catch (e) {
              if (kDebugMode) {
                print('Error occurred: $e');
              } // Catch network errors
            }
          },
        ),
      ],
    );
  }
}

// Define your next screen here
class NextScreen extends StatelessWidget {
  const NextScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Welcome')),
      body: const Center(
        child: Text('You are now logged in!'),
      ),
    );
  }
}
