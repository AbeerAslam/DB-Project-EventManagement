import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;
  final double width;
  final double height;

  const CustomButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
    this.width = 250,
    this.height = 100,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: const LinearGradient(
          colors: [
            Color.fromARGB(255, 207, 120, 33),
            Color.fromARGB(255, 233, 208, 84),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(2, 4),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(0),
          backgroundColor: Colors.transparent, // Use gradient instead
          elevation: 0,
          side: const BorderSide(
            color: Color.fromARGB(255, 230, 167, 129), // Border color
            width: 0.5,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Stack(
          children: [
            Center(
              child: Text(
                buttonText,
                style: const TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 25,
                  letterSpacing: 0.4,
                  color: Colors.white, // Text color
                ),
              ),
            ),
            Positioned(
              top: 2,
              left: 2,
              right: 2,
              child: Container(
                height: height * 0.1,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
