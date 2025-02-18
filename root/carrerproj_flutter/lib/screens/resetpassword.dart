import 'package:flutter/material.dart';
import 'package:serverpod_auth_email_flutter/serverpod_auth_email_flutter.dart';
import 'package:authinticationproj_flutter/src/serverpod_client.dart';
import 'package:authinticationproj_flutter/screens/createpassword.dart';

class ResetPassPage extends StatefulWidget {
  const ResetPassPage({super.key});

  @override
  _ResetPassPageState createState() => _ResetPassPageState();
}

class _ResetPassPageState extends State<ResetPassPage> {
  final TextEditingController _emailController = TextEditingController();
  final authController = EmailAuthController(client.modules.auth);

  Future<void> _reset() async {
    await authController.initiatePasswordReset(_emailController.text);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CreatePassPage()),
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
                'Reset a Password',
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
              ElevatedButton(
                onPressed: _reset,
                child: Text('Create'),
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