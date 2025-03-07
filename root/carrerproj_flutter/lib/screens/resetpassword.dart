import 'package:flutter/material.dart';
import 'package:serverpod_auth_email_flutter/serverpod_auth_email_flutter.dart';
import 'package:carrerproj_flutter/src/serverpod_client.dart';
import 'package:carrerproj_flutter/screens/createpassword.dart';

class ResetPassPage extends StatefulWidget {
  const ResetPassPage({super.key});

  @override
  _ResetPassPageState createState() => _ResetPassPageState();
}

class _ResetPassPageState extends State<ResetPassPage> {
  final TextEditingController _emailController = TextEditingController();
  final authController = EmailAuthController(client.modules.auth);
  bool _isButtonEnabled = false;
  String? _errorMessage;

  void _checkFields() {
    setState(() {
      _isButtonEnabled = _emailController.text.isNotEmpty;
      _errorMessage = null; // Clear error when text changes
    });
  }

  Future<void> _reset() async {
    bool success = await authController.initiatePasswordReset(_emailController.text);
    if (success) {
      _showValidatePopup(_emailController.text);
    } else {
      setState(() {
        _errorMessage = "The email doesn't exist. Please try again.";
      });
    }
  }


  void _showValidatePopup(String email) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ValidatePopup(email: email);
      },
    );
  }

  
  @override
  void initState() {
    super.initState();

    // Add listeners to check fields for changes
    _emailController.addListener(_checkFields);
  }

  @override
  void dispose() {
    // Dispose controllers when done
    _emailController.removeListener(_checkFields);
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
                'Reset a Password',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: 400,
                child: Column(
                  children: [
                    TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      _errorMessage ?? '',
                      style: TextStyle(color: Colors.red),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _isButtonEnabled ? _reset : null,
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

class ValidatePopup extends StatefulWidget {
  final String email;
  const ValidatePopup({required this.email, Key? key}) : super(key: key);

  @override
  _ValidatePopupState createState() => _ValidatePopupState();
}

class _ValidatePopupState extends State<ValidatePopup> {
  final TextEditingController _codeController = TextEditingController();
  final authController = EmailAuthController(client.modules.auth);
  bool _isButtonEnabled = false;

  void _checkFields() {
    setState(() {
      _isButtonEnabled = _codeController.text.isNotEmpty;
    });
  }

  Future<void> _validate() async {
    if (_isButtonEnabled) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => CreatePassPage(
            email: widget.email,
            code: _codeController.text,
          ),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _codeController.addListener(_checkFields);
  }

  @override
  void dispose() {
    _codeController.removeListener(_checkFields);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'Validate the Account',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: 300,
              child: TextField(
                controller: _codeController,
                decoration: InputDecoration(
                  labelText: 'Verification Code',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isButtonEnabled ? _validate : null,
              child: Text('Validate Email'),
            ),
          ],
        ),
      ),
    );
  }
}