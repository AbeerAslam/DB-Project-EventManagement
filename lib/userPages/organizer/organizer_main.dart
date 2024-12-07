import 'package:event_management/models/navigation_bar.dart';
import 'package:flutter/material.dart';

import 'attendee_registeration_manager.dart';
import 'event_request.dart';
import 'view_requests.dart';

class OrganizerMain extends StatefulWidget {
  final String email;
  const OrganizerMain({super.key, required this.email});

  @override
  OrganizerMainState createState() => OrganizerMainState();
}

class OrganizerMainState extends State<OrganizerMain> {
  @override
  Widget build(BuildContext context) {
    return  CustomNavigationBar(
      destinations: const <NavigationDestination>[
        NavigationDestination(
          selectedIcon: Icon(Icons.create_sharp, color: Colors.white),
          icon: Icon(Icons.create_outlined, color: Colors.white),
          label: 'Create Requests',
        ),
        NavigationDestination(
          selectedIcon: Icon(Icons.view_list_sharp, color: Colors.white),
          icon: Icon(Icons.view_list_outlined, color: Colors.white),
          label: 'View Requests',
        ),
        NavigationDestination(
          selectedIcon: Icon(Icons.people, color: Colors.white),
          icon: Icon(Icons.people_outline, color: Colors.white),
          label: 'Attendee Registration',
        ),
      ],
      pages: <Widget>[
        CreateEventRequestScreen(),
        const ViewRequestsScreen(),
        const OrganizerEventManagement()
      ],
      //selectedItemColor: Colors.blueAccent,
      //unselectedItemColor: Colors.grey,
    );
  }
}