import 'package:event_management/userPages/Admin/admin_emp.dart';
import 'package:flutter/material.dart';
import 'package:event_management/models/navigation_bar.dart';

import '../../models/logs.dart';
import 'admin_log.dart'; // Import the responsive nav bar

class Admin extends  StatefulWidget {
  const Admin({super.key});

  @override
  State<Admin> createState() => _AdminState();
}
class _AdminState extends State<Admin> with WidgetsBindingObserver {
  final String userEmail = "admin@gmail.com"; // Example email, this should be dynamic
  final String userRole = "Admin"; // Example role

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    // Log that the user has entered the dashboard page
    _logActivity(' logged in');
  }

  @override
  void dispose() {
    // Log that the user is leaving the dashboard page
    _logActivity(' logged out');
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  // Function to log activity
  Future<void> _logActivity(String activity) async {
    Logs logs = Logs();
    await logs.logActivity(userEmail, userRole, activity);
  }

  @override
  Widget build(BuildContext context) {

    return  CustomNavigationBar(
      destinations: const <NavigationDestination>[
        NavigationDestination(
          selectedIcon: Icon(Icons.people_sharp, color: Colors.white),
          icon: Icon(Icons.people_outlined, color: Colors.white),
          label: 'Employees',
        ),
        NavigationDestination(
          selectedIcon: Icon(Icons.notifications_sharp, color: Colors.white),
          icon: Icon(Icons.notifications_outlined, color: Colors.white),
          label: 'Requests',
        ),
        NavigationDestination(
          selectedIcon: Icon(Icons.fact_check_sharp, color: Colors.white),
          icon: Icon(Icons.fact_check_outlined, color: Colors.white),
          label: 'Logs',
        ),
      ],
      pages: const <Widget>[




       EmployeeScreen(),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Card(
                child: ListTile(
                  leading: Icon(Icons.notifications_sharp),
                  title: Text('Notification 1'),
                  subtitle: Text('This is a notification'),
                ),
              ),
              Card(
                child: ListTile(
                  leading: Icon(Icons.notifications_sharp),
                  title: Text('Notification 2'),
                  subtitle: Text('This is a notification'),
                ),
              ),
            ],
          ),
        ),
        LogScreen(),
      ],

    );
  }
}

