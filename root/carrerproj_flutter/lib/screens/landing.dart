import 'package:flutter/material.dart';
import 'package:carrerproj_flutter/screens/signup.dart';
import 'package:carrerproj_flutter/screens/login.dart';
import 'package:google_fonts/google_fonts.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset(
          'lib/assets/colored_logo.png', // Colored logo in the header (in assets folder)
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'lib/assets/white_logo.png', // White logo above the box (in assets folder)
                height: 200, // Adjust size as needed
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(30),
                width: 400,
                decoration: BoxDecoration(
                  color: Color(0xFF3AB8B5).withOpacity(0.3), // Teal/Cyan with transparency
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
                  children: [
                    /// Large Welcome Text
                    const Text(
                      'Welcome to Aoun',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1A2E44), // Dark Blue for contrast
                      ),
                    ),
                    const SizedBox(height: 20),

                    /// Sign-Up Button
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignUpPage()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                        textStyle: const TextStyle(fontSize: 18),
                        backgroundColor: Color(0xFF3AB8B5), // Teal/Cyan
                        foregroundColor: Color(0xFFFFFFFF), // White text/icons
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text('Sign Up'),
                    ),

                    const SizedBox(height: 10),

                    /// Log In Text Button
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );
                      },
                      child: Text(
                        'Log in instead',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF3AB8B5), // Teal/Cyan
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}