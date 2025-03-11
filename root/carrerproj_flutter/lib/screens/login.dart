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
        title: Text(
          'Career Consulting',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.blueAccent,
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Log In',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: 400,
                child: TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
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
                    border: OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    ),
                  ),
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
                child: Text('Forgot password?'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _isButtonEnabled ? _login : null, // Enable/Disable button based on _isButtonEnabled
                child: Text('Log In'),
              ),
              // Show the error message below the button if there is one
              if (_errorMessage != null)
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    _errorMessage!,
                    style: TextStyle(color: Colors.red, fontSize: 14),
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
                child: Text('Sign Up Instead'),
              ),
              SizedBox(height: 20),
            ],
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
              child: Text('About us'),
            ),
          ],
        )
      ],
    );
  }
}