import 'package:flutter/material.dart';
import 'package:authinticationproj_flutter/src/serverpod_client.dart';
import 'package:serverpod_auth_email_flutter/serverpod_auth_email_flutter.dart';
import 'package:authinticationproj_flutter/screens/validateaccount.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final authController = EmailAuthController(client.modules.auth);
  
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  String _userType = 'User';

  Future<void> _signUp() async {
    await authController.createAccountRequest(_userController.text,_emailController.text, _passwordController.text);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ValidatePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Career Consulting'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Sign Up',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: 400,
                child: TextField(
                  controller: _userController,
                  decoration: InputDecoration(
                    labelText: 'User Name',
                    border: OutlineInputBorder(),
                  ),
                ),
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
                        _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
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
              SizedBox(
                width: 400,
                child: TextField(
                  controller: _confirmPasswordController,
                  obscureText: !_isConfirmPasswordVisible,
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    border: OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isConfirmPasswordVisible ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                        });
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Select User Type:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Radio(
                    value: 'User',
                    groupValue: _userType,
                    onChanged: (value) {
                      setState(() {
                        _userType = value.toString();
                      });
                    },
                  ),
                  Text('User'),
                  SizedBox(width: 20),
                  Radio(
                    value: 'Consultant',
                    groupValue: _userType,
                    onChanged: (value) {
                      setState(() {
                        _userType = value.toString();
                      });
                    },
                  ),
                  Text('Consultant'),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _signUp, // Call sign-up function
                child: Text('Sign Up'),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
      persistentFooterButtons: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [TextButton(
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