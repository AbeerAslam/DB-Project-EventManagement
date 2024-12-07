import 'package:flutter/material.dart';
import 'package:event_management/models/app_bar.dart';
import 'package:event_management/api_service.dart';

class ViewRequestsScreen extends StatefulWidget {
  const ViewRequestsScreen({super.key});

  @override
  ViewRequestsScreenState createState() => ViewRequestsScreenState();
}

class ViewRequestsScreenState extends State<ViewRequestsScreen> {
  late Future<List<Map<String, dynamic>>> eventRequests;

  @override
  void initState() {
    super.initState();
    eventRequests = ApiService.getAllEventRequests();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(titleText: "View Requests", true, true).buildAppBar(),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: eventRequests,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No event requests found."));
          }

          return ListView(
            children: snapshot.data!.map((request) {
              return Card(
                color:const Color.fromARGB(255, 16, 42, 67),
                child: ListTile(
                  title: Text(request['event_name']),
                  subtitle: Text("Status: ${request['status']}"),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
