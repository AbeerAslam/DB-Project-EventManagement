import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EventsList extends StatefulWidget {
  const EventsList({super.key});

  @override
  State<EventsList> createState() => _EventsList();
}

class _EventsList extends State<EventsList> {
  List<dynamic> events = []; // To hold events
  bool isLoading = true; // To manage loading state
  String errorMessage = ''; // To hold error messages if any

  @override
  void initState() {
    super.initState();
    fetchEvents(); // Fetch events when the widget initializes
  }

  Future<void> fetchEvents() async {
    try {
      final response = await http.get(Uri.parse('http://10.0.2.2:3000/test')); // Update URL as per your API endpoint
      if (response.statusCode == 200) {
        final List<dynamic> eventList = json.decode(response.body);
        setState(() {
          events = eventList; // Update events list
          isLoading = false; // Set loading to false
        });
      } else {
        setState(() {
          isLoading = false;
          errorMessage = 'Failed to load events.';
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = 'Error: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator()); // Show loading indicator
    }

    if (errorMessage.isNotEmpty) {
      return Center(child: Text(errorMessage)); // Show error message
    }

    if (events.isEmpty) {
      return const Center(child: Text('No events available.')); // Show no events message
    }

    return ListView.builder(
      itemCount: events.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(events[index]['emp_id']), // Adjust according to your event data structure
          subtitle: Text(events[index]['role']), // Adjust according to your event data structure
        );
      },
    );
  }
}
