import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:event_management/models/app_bar.dart';

class OrganizerEventManagement extends StatefulWidget
{
  const OrganizerEventManagement({super.key});

  @override
  State<OrganizerEventManagement> createState() => _OrganizerEventManagementState();
}

class _OrganizerEventManagementState extends State<OrganizerEventManagement> {
  List<dynamic> attendees = [];

  Future<void> fetchAttendees() async {
    final response = await http.get(
        Uri.parse('http://10.0.2.2:3000/api/attendees/registrations'));
    if (response.statusCode == 200) {
      setState(() {
        attendees = jsonDecode(response.body);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Failed to load attendees. Error: ${response.body}')),
      );
    }
  }

  Future<void> updateRegistrationStatus(int attendeeId, int eventId,
      String eligibility, String registration) async
  {
    try {
      final response = await http.put(
        Uri.parse('http://10.0.2.2:3000/api/attendees/update_status'),
        headers: {
          "Content-Type": "application/json",
          "x_api_key": "b289e137-cbfe-4a20-9c71-8285389b62c8",
        },
        body: jsonEncode({
          'attendeeId': attendeeId,
          'eventId': eventId,
          'eligibilityStatus': eligibility,
          'registrationStatus': registration,
        }),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Status updated successfully!')),
        );
        fetchAttendees();
      } else {
        throw Exception('Failed to update status');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(titleText: "Registration", true, true).buildAppBar(),
      body: Column(
        children: [
          const SizedBox(height: 16), // Add space between AppBar and ListView
          Expanded(
            child: ListView.builder(
              itemCount: attendees.length,
              itemBuilder: (context, index) {
                final attendee = attendees[index];
                // Fallback to 'Pending' if the value is not in the predefined list
                final validStatuses = ['Pending', 'Approved', 'Rejected'];
                final registrationStatus = validStatuses.contains(
                    attendee['registration_status'])
                    ? attendee['registration_status']
                    : 'Pending';

                return Card(
                  child: ListTile(
                    title: Text(attendee['name'] ?? 'Unknown'),
                    subtitle: Text(
                        "Event: ${attendee['event_id'] ??
                            'N/A'}, Status: $registrationStatus"),
                    trailing: DropdownButton<String>(
                      value: registrationStatus,
                      items: validStatuses
                          .map((status) =>
                          DropdownMenuItem(value: status, child: Text(status)))
                          .toList(),
                      onChanged: (newStatus) {
                        if (newStatus != null) {
                          final eligibilityStatus = newStatus == 'Approved'
                              ? 'Eligible'
                              : 'Not Eligible';
                          updateRegistrationStatus(
                            attendee['attendee_id'] ?? 0,
                            // Fallback to a default value
                            attendee['event_id'] ?? 0,
                            // Fallback to a default value
                            eligibilityStatus,
                            newStatus,
                          );
                        }
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}