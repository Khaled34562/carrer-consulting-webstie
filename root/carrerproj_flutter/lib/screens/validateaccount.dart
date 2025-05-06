import 'package:flutter/material.dart';
import 'package:serverpod_auth_email_flutter/serverpod_auth_email_flutter.dart';
import 'package:carrerproj_flutter/src/serverpod_client.dart';
import 'package:carrerproj_flutter/screens/login.dart';

class ValidatePage extends StatefulWidget {
  const ValidatePage({super.key});

  @override
  _ValidatePageState createState() => _ValidatePageState();
}

class _ValidatePageState extends State<ValidatePage> {
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final authController = EmailAuthController(client.modules.auth);

  Future<void> _validate() async {
    await authController.validateAccount(_emailController.text, _codeController.text);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset(
          'lib/assets/colored_logo.png', // Colored logo in the header
          height: 50, // Adjust size as needed
        ),
      ),
      backgroundColor: Colors.transparent, // Transparent for gradient
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF1A2E44), // Dark Blue
              Color(0xFF3AB8B5), // Teal/Cyan
            ],
            stops: [0.0, 0.7], // Emphasize teal more, closer to the first picture
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'lib/assets/white_logo.png', // White logo above the form
                  height: 100, // Adjust size as needed
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(30),
                  width: 400,
                  decoration: BoxDecoration(
                    color: Colors.white, // White background for the box
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        'Validate the Account',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1A2E44), // Dark Blue for contrast
                        ),
                      ),
                      SizedBox(height: 20),
                      SizedBox(
                        width: 400,
                        child: TextField(
                          controller: _codeController,
                          decoration: InputDecoration(
                            labelText: 'Verification Code',
                            labelStyle: TextStyle(color: Color(0xFF3AB8B5)), // Teal/Cyan
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF3AB8B5)), // Teal/Cyan
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF3AB8B5)), // Teal/Cyan
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF3AB8B5)), // Teal/Cyan
                            ),
                          ),
                          style: TextStyle(color: Color(0xFF1A2E44)), // Dark Blue text for input
                        ),
                      ),
                      SizedBox(height: 20),
                      SizedBox(
                        width: 400,
                        child: TextField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            labelStyle: TextStyle(color: Color(0xFF3AB8B5)), // Teal/Cyan
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF3AB8B5)), // Teal/Cyan
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF3AB8B5)), // Teal/Cyan
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF3AB8B5)), // Teal/Cyan
                            ),
                          ),
                          style: TextStyle(color: Color(0xFF1A2E44)), // Dark Blue text for input
                        ),
                      ),
                      SizedBox(height: 20),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _validate,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                          textStyle: const TextStyle(fontSize: 18),
                          backgroundColor: Color(0xFF3AB8B5), // Teal/Cyan
                          foregroundColor: Color(0xFFFFFFFF), // White text/icons
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text('Validate Account'),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}