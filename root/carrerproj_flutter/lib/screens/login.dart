import 'package:flutter/material.dart';
import 'package:serverpod_auth_email_flutter/serverpod_auth_email_flutter.dart';
import 'package:carrerproj_flutter/src/serverpod_client.dart';
import 'package:carrerproj_flutter/screens/signup.dart';
import 'package:carrerproj_flutter/screens/resetpassword.dart';
import 'package:carrerproj_flutter/screens/consultant/homepage.dart';
import 'package:carrerproj_flutter/screens/user/homepage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final authController = EmailAuthController(client.modules.auth);
  bool _isPasswordVisible = false;
  String? _errorMessage;
  bool _isButtonEnabled = false;

  // Function to check if both fields are filled
  void _checkFields() {
    setState(() {
      _isButtonEnabled = _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;
    });
  }

  Future<void> _login() async {
    try {
      // Attempt to sign in
      final userInfo = await authController.signIn(_emailController.text, _passwordController.text);

      if (userInfo != null) {
        // Fetch user details from your Serverpod database
        final user = await client.user.getUserProfile(userInfo.id ?? 0);

        if (user != null) {
          if (user.role == 'Consultant') {
            // Navigate to Consultant Dashboard
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => DashboardPage()),
            );
          } else {
            // Navigate to User Dashboard
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => DashboardPageUser()),
            );
          }
        } else {
          setState(() {
            _errorMessage = 'User not found in the database';
          });
        }
      } else {
        setState(() {
          _errorMessage = 'Invalid email or password';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'An error occurred. Please try again.';
      });
    }
  }

  @override
  void initState() {
    super.initState();

    // Add listeners to check fields for changes
    _emailController.addListener(_checkFields);
    _passwordController.addListener(_checkFields);
  }

  @override
  void dispose() {
    // Dispose controllers when done
    _emailController.removeListener(_checkFields);
    _passwordController.removeListener(_checkFields);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset(
          'lib/assets/colored_logo.png', // Colored logo in the header
          height: 75, // Adjust size as needed
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
                  height: 200, // Adjust size as needed
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
                        'Log In',
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
                      SizedBox(
                        width: 400,
                        child: TextField(
                          controller: _passwordController,
                          obscureText: !_isPasswordVisible,
                          decoration: InputDecoration(
                            labelText: 'Password',
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
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Color(0xFF3AB8B5), // Teal/Cyan
                              ),
                              onPressed: () {
                                setState(() {
                                  _isPasswordVisible = !_isPasswordVisible;
                                });
                              },
                            ),
                          ),
                          style: TextStyle(color: Color(0xFF1A2E44)), // Dark Blue text for input
                        ),
                      ),
                      SizedBox(height: 20),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ResetPassPage()),
                          );
                        },
                        child: Text(
                          'Forgot password?',
                          style: TextStyle(color: Color(0xFF3AB8B5)), // Teal/Cyan
                        ),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _isButtonEnabled ? _login : null, // Enable/Disable button
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                          textStyle: const TextStyle(fontSize: 18),
                          backgroundColor: Color(0xFF3AB8B5), // Teal/Cyan
                          foregroundColor: Color(0xFFFFFFFF), // White text/icons
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text('Log In'),
                      ),
                      // Show the error message below the button if there is one
                      if (_errorMessage != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text(
                            _errorMessage!,
                            style: TextStyle(color: Color(0xFFFFC107), fontSize: 14), // Yellow for visibility
                          ),
                        ),
                      SizedBox(height: 20),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SignUpPage()),
                          );
                        },
                        child: Text(
                          'Sign Up Instead',
                          style: TextStyle(color: Color(0xFF3AB8B5)), // Teal/Cyan
                        ),
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
      persistentFooterButtons: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                // Navigate to about us page
              },
              child: Text(
                'About us',
                style: TextStyle(color: Color(0xFFFFFFFF)), // White text
              ),
            ),
          ],
        )
      ],
    );
  }
}