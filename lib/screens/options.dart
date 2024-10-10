import 'dart:async';
import 'package:flutter/material.dart';

class Options extends StatefulWidget {
  const Options({super.key});

  @override
  State <Options> createState() => _OptionsState();
}

class _OptionsState extends State<Options> {
  bool _showAdminButton = false;
  bool _showManagementButton = false;
  bool _showAttendeesButton = false;

  @override
  void initState() {
    super.initState();

    // Timer to show Admin button after 2 seconds
    Timer(const Duration(milliseconds: 0), () {
      setState(() {
        _showAdminButton = true;
      });
    });

    Timer(const Duration(milliseconds: 300), () {
      setState(() {
        _showManagementButton = true;
      });
    });

    // Timer to show Attendees button after 6 seconds
    Timer(const Duration(milliseconds: 600), () {
      setState(() {
        _showAttendeesButton = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Options Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_showAdminButton) // Show Admin button after the delay
              ElevatedButton(
                onPressed: () {
                  // Navigate to Admin screen or perform an action
                },
                child: const Text('Admin'),
              ),
            const SizedBox(height: 20),

            if (_showManagementButton) // Show Management button after the delay
              ElevatedButton(
                onPressed: () {
                  // Navigate to Management screen or perform an action
                },
                child: const Text('Management'),
              ),
            const SizedBox(height: 20),

            if (_showAttendeesButton) // Show Attendees button after the delay
              ElevatedButton(
                onPressed: () {
                  // Navigate to Attendees screen or perform an action
                },
                child: const Text('Attendees'),
              ),
          ],
        ),
      ),
    );
  }
}
