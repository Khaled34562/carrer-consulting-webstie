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
                        'Reset a Password',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1A2E44), // Dark Blue for contrast
                        ),
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
                            SizedBox(height: 8),
                            Text(
                              _errorMessage ?? '',
                              style: TextStyle(color: Color(0xFFFFC107)), // Yellow for visibility
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _isButtonEnabled ? _reset : null,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                          textStyle: const TextStyle(fontSize: 18),
                          backgroundColor: Color(0xFF3AB8B5), // Teal/Cyan
                          foregroundColor: Color(0xFFFFFFFF), // White text/icons
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text('Create'),
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
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A2E44), // Dark Blue for contrast
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: 300,
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
            ElevatedButton(
              onPressed: _isButtonEnabled ? _validate : null,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                textStyle: const TextStyle(fontSize: 18),
                backgroundColor: Color(0xFF3AB8B5), // Teal/Cyan
                foregroundColor: Color(0xFFFFFFFF), // White text/icons
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text('Validate Email'),
            ),
          ],
        ),
      ),
    );
  }
}