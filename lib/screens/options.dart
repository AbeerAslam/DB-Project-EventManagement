import 'package:flutter/material.dart';
import 'package:event_management/screens/event_category.dart';
import 'package:event_management/models/input_password_dialog.dart';

class Options extends StatefulWidget {
  const Options({super.key});

  @override
  State<Options> createState() => _Options();
}

class _Options extends State<Options> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 33, 9, 78),
          automaticallyImplyLeading: false,
          title: const Align(
            alignment: AlignmentDirectional(0, 0),
            child: Text(
              'Welcome',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Montserrat',
                color: Colors.white,
                fontSize: 35,
                letterSpacing: 0.0,
              ),
            ),
          ),
          elevation: 2,
        ),
        body: SafeArea(
          top: true,
          child: Stack(
            children: [
              Align(
                alignment: const AlignmentDirectional(0, -0.5),
                child: CustomButton(
                  buttonText: 'Admin',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PasswordDialog(
                          email: 'admin@gmail.com',
                          onSubmit: (String email,String password) {
                            // Handle password submission
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
              Align(
                alignment: const AlignmentDirectional(0, 0),
                child: CustomButton(
                  buttonText: 'Management',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ManagementOptions(),
                      ),
                    );
                  },
                ),
              ),
              Align(
                alignment: const AlignmentDirectional(0, 0.5),
                child: CustomButton(
                  buttonText: 'Attendee',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const EventCategory(),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



class ManagementOptions extends StatelessWidget{
late final String buttonText;
late final VoidCallback onPressed;
final scaffoldKey = GlobalKey<ScaffoldState>();

ManagementOptions({super.key});


@override
Widget build(BuildContext context) {
  return GestureDetector(
    onTap: () => FocusScope.of(context).unfocus(),
    child: Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 33, 9, 78),
        foregroundColor: const Color.fromARGB(255, 255, 255, 255),
        toolbarHeight: 64,
        title: const Align(
          alignment: AlignmentDirectional(-0.5, 0),
          child: Text(
            'Management',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Montserrat',
              color: Color.fromARGB(255, 255, 255, 255),
              fontSize: 35,
              letterSpacing: 0.0,
            ),
          ),
        ),
        elevation: 2,
      ),
      body: SafeArea(
        top: true,
        child: Stack(
          children: [
            Align(
              alignment: const AlignmentDirectional(0, -0.5),
              child: CustomButton(
                buttonText: 'Organizer',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PasswordDialog(
                        email: 'organizer?@gmail.com',
                        onSubmit: (String email,String password) {
                          // Handle password submission
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
            Align(
              alignment: const AlignmentDirectional(0, 0),
              child: CustomButton(
                buttonText: 'Coordinator',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PasswordDialog(
                        email: 'coordinator?@gmail.com',
                        onSubmit: (String email,String password) {
                          // Handle password submission
                        },
                      ),
                    ),
                  );
                  // Navigate to management screen
                },
              ),
            ),
            Align(
              alignment: const AlignmentDirectional(0, 0.5),
              child: CustomButton(
                buttonText: 'Support Specialist',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PasswordDialog(
                        email: 'support?@gmail.com',
                        onSubmit: (String email,String password) {
                          // Handle password submission
                        },
                      ),
                    ),
                  );

                },
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
}


// Custom Button Defined Inside the Options Class
class CustomButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;

  const CustomButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(300, 65),
        padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
        backgroundColor: const Color.fromARGB(255, 33, 9, 78), // Button background color
        foregroundColor: const Color.fromARGB(255, 255, 255, 255), // Text color (white)
        textStyle: const TextStyle(
          fontFamily: 'Montserrat',
          fontSize: 20,
          letterSpacing: 0.4,
        ),
        elevation: 0,
        side: const BorderSide(
          color: Color.fromARGB(255, 189, 197, 36), // Border color
          width: 0.5,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8), // Border radius
        ),
      ),
      child: Text(buttonText),
    );
  }
}