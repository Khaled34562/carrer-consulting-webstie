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
          suffixIcon: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (controller.text.isNotEmpty)
                Tooltip(
                  message: isValid && isMatching ? 'Valid' : 'Password must be at least 8 characters with letters, numbers, and special characters.',
                  child: Icon(
                    isValid && isMatching ? Icons.check_circle : Icons.cancel,
                    color: isValid && isMatching ? Color(0xFF3AB8B5) : Color(0xFFFFC107), // Teal for valid, Yellow for invalid
                  ),
                ),
              IconButton(
                icon: Icon(
                  isVisible ? Icons.visibility : Icons.visibility_off,
                  color: Color(0xFF3AB8B5), // Teal/Cyan
                ),
                onPressed: toggleVisibility,
              ),
            ],
          ),
        ),
        style: TextStyle(color: Color(0xFF1A2E44)), // Dark Blue text for input
      ),
    );
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
                        'Create a New Password',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1A2E44), // Dark Blue for contrast
                        ),
                      ),
                      SizedBox(height: 20),
                      _buildPasswordField(
                        controller: _passwordController,
                        label: 'Password',
                        isVisible: _isPasswordVisible,
                        toggleVisibility: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                      ),
                      SizedBox(height: 20),
                      _buildPasswordField(
                        controller: _confirmPasswordController,
                        label: 'Confirm Password',
                        isVisible: _isConfirmPasswordVisible,
                        toggleVisibility: () {
                          setState(() {
                            _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                          });
                        },
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _isButtonEnabled ? _create : null,
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