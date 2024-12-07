import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:vibration/vibration.dart';
import 'dart:convert';

import '../userPages/Admin/admin_main.dart';
import '../userPages/Support/support_main.dart';
import '../userPages/cordinator/coordinator_main.dart';
import '../userPages/organizer/organizer_main.dart';

class PasswordDialog extends StatelessWidget {
  final String user;
  final String email;
  final Function(String, String) onSubmit;

  const PasswordDialog({
    required this.email,
    required this.user,
    required this.onSubmit,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Controllers for the text fields
    TextEditingController emailController = TextEditingController(text: email);
    TextEditingController passwordController = TextEditingController();

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
                  'Login',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: emailController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: "Enter your email",
                    hintStyle: const TextStyle(color: Colors.white70),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.2),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: "Enter your password",
                    hintStyle: const TextStyle(color: Colors.white70),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.2),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 24,
                        ),
                        backgroundColor: const Color.fromARGB(255, 255, 165, 0),
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          //side: const BorderSide(color: Colors.white70),
                        ),
                      ),
                      child: const Text('Cancel',
                      style: TextStyle(color: Colors.white),
                      )
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        String inputEmail = emailController.text;
                        String inputPassword = passwordController.text;

                        try {
                          final response = await http.post(
                            Uri.parse('http://10.0.2.2:3000/api/verify-password'),
                            headers: {'Content-Type': 'application/json'},
                            body: json.encode(
                              {'email': inputEmail, 'password': inputPassword},
                            ),
                          );

                          if (response.statusCode == 200) {
                            onSubmit(inputEmail, inputPassword);
                            //final responseBody = json.decode(response.body);

                            if (user == 'admin') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Admin(),
                                ),
                              );
                            } else if (user == 'support') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      Support(email: inputEmail),
                                ),
                              );
                            }
                            else if (user == 'organizer') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                    OrganizerMain( email: inputEmail),
                                ),
                              );
                            }
                            else if (user == 'coordinator') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                    const CoordinatorHome()
                                ),
                              );
                            }
                          } else if (response.statusCode == 401) {
                            if (await Vibration.hasVibrator() == true) {
                              Vibration.vibrate(duration: 1000);
                            }
                          }
                        } catch (e) {
                          if (kDebugMode) {
                            print('Error occurred: $e');
                          }
                        }
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
                        'Submit',
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
                Icons.lock_outline,
                size: 40,
                color: Colors.deepPurple.shade700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
