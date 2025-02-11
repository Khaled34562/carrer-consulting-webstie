import 'package:flutter/material.dart';

class CodeVerificationPage extends StatelessWidget {
  final _codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Verify Code'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _codeController,
              decoration: InputDecoration(
                labelText: 'Verification Code',
                hintText: 'Enter the code sent to your email',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Here you would typically verify the code
                // For now, just navigate back
                Navigator.pop(context);
              },
              child: Text('Verify Code'),
            ),
          ],
        ),
      ),
    );
  }
}