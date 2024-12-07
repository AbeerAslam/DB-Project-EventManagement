import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../models/app_bar.dart';

class EmployeeScreen extends StatefulWidget {
  const EmployeeScreen({super.key});

  @override
  State<EmployeeScreen> createState() => _EmployeeScreenState();
}

class _EmployeeScreenState extends State<EmployeeScreen> {
  List<Map<String, dynamic>> employees = [];
  List<Map<String, dynamic>> filteredEmployees = []; // For filtered results
  final TextEditingController searchController = TextEditingController(); // Controller for search


  @override
  void initState() {
    super.initState();
    _fetchEmployees(); // Fetch employees on init
  }

  // API endpoint
  final String apiUrl = 'http://10.0.2.2:3000/api/employees';

  // Show confirmation dialog for deletion
  void _showDeleteDialog(int id) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.blueGrey,
        title: const Text("Confirm Deletion"),
        actions: <Widget>[
          ElevatedButton(
            onPressed: () {
              _deleteEmployee(id);
              Navigator.of(ctx).pop(); // Close the dialog
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text("Delete",style:TextStyle(color: Colors.white)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            child: const Text("Close",style:TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  // Show edit employee dialog
  void showEmpDialog(String operation, int id, String fullName, String phone, String email, String hireDate, String role) {
    // Convert phone and hireDate to strings if they are not already
    final fullNameController = TextEditingController(text: fullName,);
    final phoneController = TextEditingController(text: phone.toString()); // Ensure phone is a string
    final emailController = TextEditingController(text: email);
    final hireDateController = TextEditingController(text: hireDate.toString()); // Ensure hireDate is a string
    final roleController = TextEditingController(text: role);

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color.fromARGB(255, 19, 18, 18),
        title: Text("$operation Employee",style:(const TextStyle(color: Colors.white))),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: fullNameController,
            style: const TextStyle(color: Colors.grey),
              cursorColor: Colors.orangeAccent,
              decoration: const InputDecoration(labelText: 'Full Name',
                  labelStyle:  TextStyle(color: Colors.white),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.orange, width: 2.0),),)
            ),
            TextField(
              controller: phoneController,
              cursorColor: Colors.orangeAccent,
              decoration: const InputDecoration(labelText: 'Phone',labelStyle:  TextStyle(color: Colors.white),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.orange, width: 2.0),)),
              keyboardType: TextInputType.phone,
            ),
            TextField(
              controller: emailController,
              cursorColor: Colors.orangeAccent,
              decoration: const InputDecoration(labelText: 'Email',labelStyle:  TextStyle(color: Colors.white),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.orange, width: 2.0),),)
            ),
            TextField(
              controller: hireDateController,
              cursorColor: Colors.orangeAccent,
              decoration: const InputDecoration(labelText: 'Hire Date',labelStyle:  TextStyle(color: Colors.white),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.orange, width: 2.0),),)
            ),
            TextField(
              cursorColor: Colors.orangeAccent,
              controller: roleController,
              decoration: const InputDecoration(labelText: 'Role',labelStyle:  TextStyle(color: Colors.white),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.orange, width: 2.0),),)
            ),
          ],
        ),
        actions: <Widget>[
          ElevatedButton(
            onPressed: () {
              if (operation == 'add') {
                _addEmployee(
                  fullNameController.text,
                  phoneController.text,
                  emailController.text,
                  hireDateController.text,
                  roleController.text,
                );
              } else if (operation == 'Edit') {
                _updateEmployee(
                  id, // Use id directly
                  fullNameController.text,
                  phoneController.text,
                  emailController.text,
                  hireDateController.text,
                  roleController.text,
                );
              }
              Navigator.of(ctx).pop();
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            child: Text(operation,style:const TextStyle(color: Colors.white)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text("Cancel",style:TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }


  Future<void> _addEmployee(String fullName, String phone, String email, String hireDate, String role) async {
    try {
      final response = await http.post(
        Uri.parse('http://10.0.2.2:3000/api/emp'),
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          "Full_Name": fullName,
          "Phone": phone,
          "Email": email,
          "Hire_Date": hireDate,
          "Role": role,
          "Login_Password": "12345" // Can be customized or taken as input
        }),
      );

      if (kDebugMode) {
        print('Add Response status: ${response.statusCode}');
      }
      if (kDebugMode) {
        print('Add Response body: ${response.body}');
      }

      if (response.statusCode == 201) {
        _fetchEmployees(); // Refresh the employee list
      } else {
        throw Exception('Failed to add employee');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Add Error: $e');
      }
    }
  }

  Future<void> _fetchEmployees() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          employees = data.map((item) => {
            "Emp_ID": item['Emp_ID'],
            "Full_Name": item['Full_Name'],
            "Phone": item['Phone'],
            "Email": item['Email'],
            "Hire_Date": item['Hire_Date'],
            "Role": item['Role']
          }).toList();

          filteredEmployees = employees; // Initialize filtered list
        });
      } else {
        throw Exception('Failed to load employees');
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  void _filterEmployees(String query) {
    setState(() {
      filteredEmployees = employees.where((employee) {
        final fullName = employee['Full_Name'].toLowerCase();
        final role = employee['Role'].toLowerCase();
        final searchLower = query.toLowerCase();

        return fullName.contains(searchLower) || role.contains(searchLower);
      }).toList();
    });
  }


  Future<void> _updateEmployee(int id, String fullName, String phone, String email, String hireDate, String role) async {
    try {
      final response = await http.put(
        Uri.parse('$apiUrl/$id'),
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          "Full_Name": fullName,
          "Phone": phone,
          "Email": email,
          "Hire_Date": hireDate,
          "Role": role,
          "Login_Password": "12345" // You may need to handle passwords differently
        }),
      );

      if (kDebugMode) {
        print('Response status: ${response.statusCode}');
      }
      if (kDebugMode) {
        print('Response body: ${response.body}');
      }

      if (response.statusCode == 200) {
        _fetchEmployees(); // Refresh employee list
      } else {
        throw Exception('Failed to update employee');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Update Error: $e');
      }
    }
  }

  Future<void> _deleteEmployee(int id) async {
    try {
      final response = await http.delete(Uri.parse('$apiUrl/$id'));
      if (response.statusCode == 200) {
        _fetchEmployees(); // Refresh employee list
      } else {
        throw Exception('Failed to delete employee');
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(titleText: "Employees", true, true).buildAppBar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              onChanged: _filterEmployees, // Update list as the user types
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search, color: Colors.white),
                hintText: 'Search by name or role',
                hintStyle: const TextStyle(color: Colors.grey),
                filled: true,
                fillColor: const Color.fromARGB(210, 25, 39, 92),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredEmployees.length,
              itemBuilder: (ctx, index) {
                return Card(
                  color: const Color.fromARGB(255, 16, 42, 67),
                  margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: ListTile(
                    leading: const Icon(Icons.person, color: Colors.white),
                    title: Text(filteredEmployees[index]['Full_Name'], style: const TextStyle(color: Colors.white)),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Phone: ${filteredEmployees[index]['Phone']}',
                          style: const TextStyle(color: Colors.blue),
                        ),
                        Text(
                          'Email: ${filteredEmployees[index]['Email']}',
                          style: const TextStyle(color: Colors.green),
                        ),
                        Text(
                          'Hire Date: ${DateTime.parse(filteredEmployees[index]['Hire_Date']).toLocal().toString().split(' ')[0]}',
                          style: const TextStyle(color: Colors.pinkAccent),
                        ),
                        Text(
                          '${filteredEmployees[index]['Role']}',
                          style: const TextStyle(color: Colors.white, fontStyle: FontStyle.italic),
                        ),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.green),
                          onPressed: () {
                            final employee = filteredEmployees[index];
                            showEmpDialog(
                              'Edit',
                              employee['Emp_ID'],
                              employee['Full_Name'],
                              employee['Phone'].toString(),
                              employee['Email'].toString(),
                              employee['Hire_Date'],
                              employee['Role'],
                            );
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _showDeleteDialog(filteredEmployees[index]['Emp_ID']),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showEmpDialog('Add', 0, '', '', '', '', '');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}