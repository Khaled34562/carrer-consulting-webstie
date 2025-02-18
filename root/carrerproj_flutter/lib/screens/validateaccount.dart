import 'package:flutter/material.dart';
import 'package:serverpod_auth_email_flutter/serverpod_auth_email_flutter.dart';
import 'package:authinticationproj_flutter/src/serverpod_client.dart';
import 'package:authinticationproj_flutter/screens/login.dart';

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
        title: Text('Career Consulting'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Validate the Account',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: 400,
                child: TextField(
                  controller: _codeController,
                  decoration: InputDecoration(
                    labelText: 'Verification Code',
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
             
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _validate,
                child: Text('Validate Account'),
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