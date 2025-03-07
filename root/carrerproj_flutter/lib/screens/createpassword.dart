import 'package:flutter/material.dart';
import 'package:serverpod_auth_email_flutter/serverpod_auth_email_flutter.dart';
import 'package:carrerproj_flutter/src/serverpod_client.dart';
import 'package:carrerproj_flutter/screens/login.dart';

class CreatePassPage extends StatefulWidget {
  final String email;
  final String code;
  const CreatePassPage({required this.email, required this.code, super.key});

  @override
  _CreatePassPageState createState() => _CreatePassPageState();
}

class _CreatePassPageState extends State<CreatePassPage> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final authController = EmailAuthController(client.modules.auth);
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _isButtonEnabled = false;

  bool _isPasswordValid(String password) {
    final regex = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&-])[A-Za-z\d@$!%*?&-]{8,}$');
    return regex.hasMatch(password);
  }

  void _validateForm() {
    setState(() {
      _isButtonEnabled = _isPasswordValid(_passwordController.text) && _passwordController.text == _confirmPasswordController.text;
    });
  }

  Future<void> _create() async {
    if (!_isButtonEnabled) return;
    await authController.resetPassword(widget.email, widget.code, _passwordController.text);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  Widget _buildPasswordField({required TextEditingController controller, required String label, required bool isVisible, required Function() toggleVisibility}) {
    bool isValid = _isPasswordValid(controller.text);
    bool isMatching = controller == _confirmPasswordController ? _passwordController.text == _confirmPasswordController.text : true;
    return SizedBox(
      width: 400,
      child: TextField(
        controller: controller,
        obscureText: !isVisible,
        onChanged: (_) => _validateForm(),
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
          suffixIcon: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (controller.text.isNotEmpty)
                Tooltip(
                  message: isValid && isMatching ? 'Valid' : 'Password must be at least 8 characters with letters, numbers, and special characters.',
                  child: Icon(
                    isValid && isMatching ? Icons.check_circle : Icons.cancel,
                    color: isValid && isMatching ? Colors.green : Colors.red,
                  ),
                ),
              IconButton(
                icon: Icon(
                  isVisible ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: toggleVisibility,
              ),
            ],
          ),
        ),
      ),
    );
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
                'Create a New Password',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              _buildPasswordField(controller: _passwordController, label: 'Password', isVisible: _isPasswordVisible, toggleVisibility: () { setState(() { _isPasswordVisible = !_isPasswordVisible; }); }),
              SizedBox(height: 20),
              _buildPasswordField(controller: _confirmPasswordController, label: 'Confirm Password', isVisible: _isConfirmPasswordVisible, toggleVisibility: () { setState(() { _isConfirmPasswordVisible = !_isConfirmPasswordVisible; }); }),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _isButtonEnabled ? _create : null,
                child: Text('Create'),
              ),
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
