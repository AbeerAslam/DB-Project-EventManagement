import 'package:event_management/models/gloss_button.dart';
import 'package:event_management/userPages/Attendee/attendee_events.dart';
import 'package:flutter/material.dart';

import '../../models/navigation_bar.dart';

class Attendee extends  StatefulWidget {
  final String email; // Nullable email parameter
  const Attendee({super.key, required this.email});

  @override
  State<Attendee> createState() => _AttendeeState();
}


class _AttendeeState extends State<Attendee> with WidgetsBindingObserver {


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }


@override
Widget build(BuildContext context) {

  return  CustomNavigationBar(
    destinations: const <NavigationDestination>[
      NavigationDestination(
        selectedIcon: Icon(Icons.dashboard_sharp, color: Colors.white),
        icon: Icon(Icons.dashboard_outlined, color: Colors.white),
        label: 'Dashboard',
      ),
      NavigationDestination(
        selectedIcon: Icon(Icons.event_sharp, color: Colors.white),
        icon: Icon(Icons.event_outlined, color: Colors.white),
        label: 'Events',
      ),
    ],
    pages: <Widget>[



      GlossyButtonsPage("    View\nFeedback","   View \n Queries",'attendee',widget.email),
      EventCategory(email: widget.email)
    ],

  );
}
}




