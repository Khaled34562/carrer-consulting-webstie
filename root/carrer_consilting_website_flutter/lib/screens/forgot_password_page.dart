import 'package:flutter/material.dart';
import 'code_verification_page.dart'; // Import the code verification page

class ForgotPasswordPage extends StatelessWidget {
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forgot Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                hintText: 'Enter your email',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Here you would typically send a code to the email
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CodeVerificationPage()),
                );
              },
              child: Text('Send Code'),
            ),
          ],
        ),
      ),
    );
  }
}