import 'package:flutter/material.dart';

class CustomAppBar {
  final String titleText;
  final bool imply;
  final bool centerTitle; // Add this parameter for title alignment

  CustomAppBar(this.imply,this.centerTitle, {required this.titleText});


  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: const Color.fromARGB(255, 236, 125, 18),
      automaticallyImplyLeading: imply,
      iconTheme: const IconThemeData(color: Colors.white), // Set back arrow color
      title: Text(
        titleText,
        style: const TextStyle(
          fontFamily: 'Montserrat',
          color: Colors.white,
          fontSize: 35,
          letterSpacing: 0.0,
        ),
      ),
      centerTitle: centerTitle, // Use the centerTitle parameter
      elevation: 2,
    );
  }
}
