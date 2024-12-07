import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../models/app_bar.dart';

class LogScreen extends StatefulWidget {
  const LogScreen({super.key});

  @override
  State<LogScreen> createState() => _LogScreenState();
}

class _LogScreenState extends State<LogScreen> {
  List logs = [];
  List filteredLogs = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchLogs(); // Fetch logs when the screen loads
    searchController.addListener(() {
      filterLogs(searchController.text);  // Apply filter when search query changes
    });
  }

  // Fetch logs from API
  Future<void> fetchLogs() async {
    final response = await http.get(Uri.parse('http://10.0.2.2:3000/api/logs'));
    if (response.statusCode == 200) {
      setState(() {
        logs = json.decode(response.body);
        filteredLogs = logs; // Initially, show all logs
      });
    } else {
      throw Exception('Failed to load logs');
    }
  }

  // Filter logs based on search query
  void filterLogs(String query) {
    if (query.isEmpty) {
      setState(() {
        filteredLogs = logs; // If the search is empty, show all logs
      });
    } else {
      List filtered = logs.where((log) {
        return log['user_role'].toLowerCase().contains(query.toLowerCase());
      }).toList();

      setState(() {
        filteredLogs = filtered; // Update filtered logs based on query
      });
    }
  }

  // Delete a log entry
  Future<void> deleteLog(int id) async {
    final response = await http.delete(Uri.parse('http://10.0.2.2:3000/api/logs/$id'));
    if (response.statusCode == 200) {
      // Reload logs after deletion
      fetchLogs();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Log deleted successfully')));
    } else {
      throw Exception('Failed to delete log');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(titleText: 'Logs', true, true).buildAppBar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color.fromARGB(210, 25, 39, 92), // Light blue search bar
                hintText: 'Search by user role',
                hintStyle: const TextStyle(color: Colors.grey),
                prefixIcon: const Icon(Icons.search, color: Colors.white),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Expanded(
            child: filteredLogs.isEmpty
                ? const Center(child: Text(
              'No Logs Found',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 35,
              ),
            ))
                : ListView.builder(
              itemCount: filteredLogs.length,
              itemBuilder: (context, index) {
                return Card(
                  color: const Color.fromARGB(255, 16, 42, 67),
                  margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: ListTile(
                    title: Text('${filteredLogs[index]['user_role']} ${filteredLogs[index]['activity']}',
                        style: const TextStyle(color: Colors.white)),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          '${filteredLogs[index]['login_time']}',
                          style: const TextStyle(color: Colors.blue),
                        ),
                        Text(
                          'User ID: ${filteredLogs[index]['User_ID']}',
                          style: const TextStyle(color: Colors.green),
                        ),
                        Text(
                          'Log ID: ${filteredLogs[index]['Log_ID']}',
                          style: const TextStyle(color: Colors.yellow),
                        ),
                      ],
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            backgroundColor: Colors.blueGrey,
                            title: const Text('Confirm Deletion'),
                            actions: <Widget>[
                              ElevatedButton(
                                onPressed: () {
                                  deleteLog(filteredLogs[index]['Log_ID']);
                                  Navigator.of(ctx).pop();
                                },
                                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                                child: const Text("Delete", style: TextStyle(color: Colors.white)),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.of(ctx).pop();
                                },
                                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                                child: const Text("Close", style: TextStyle(color: Colors.white)),
                              ),
                            ],
                          ),
                        );
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
