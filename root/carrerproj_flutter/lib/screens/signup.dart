import 'package:carrerproj_client/carrerproj_client.dart';
import 'package:flutter/material.dart';
import 'package:carrerproj_flutter/src/serverpod_client.dart';
import 'package:serverpod_auth_email_flutter/serverpod_auth_email_flutter.dart';
import 'package:carrerproj_flutter/screens/login.dart';
import 'package:email_validator/email_validator.dart';
import 'package:serverpod_auth_shared_flutter/serverpod_auth_shared_flutter.dart';

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
  bool _isSignUpEnabled = false;
  String _errorMessage = '';
  String _userType = 'User';

  bool _isPasswordValid(String password) {
    final regex = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&-])[A-Za-z\d@$!%*?&-]{8,}$');
    return regex.hasMatch(password);
  }

  void _validateForm() {
    setState(() {
      _isSignUpEnabled = _userController.text.isNotEmpty &&
          EmailValidator.validate(_emailController.text) &&
          _isPasswordValid(_passwordController.text) &&
          _passwordController.text == _confirmPasswordController.text;
    });
  }

  Future<void> _signUp() async {
    if (!_isSignUpEnabled) return;

    setState(() {
      _errorMessage = '';
    });

    try {
      bool success = await authController.createAccountRequest(
          _userController.text, _emailController.text, _passwordController.text);
      if (success) {
        _showValidatePopup(_emailController.text, _userType);
      } else {
        setState(() {
          _errorMessage = 'Email already exists. Please use a different email.';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Email already exists. Please use a different email.';
      });
    }
  }

  void _showValidatePopup(String email, String userType) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ValidatePopup(email: email, userType: userType);
      },
    );
  }

  Widget _buildPasswordField(
      {required TextEditingController controller,
      required String label,
      required bool isVisible,
      required Function() toggleVisibility}) {
    bool isValid = _isPasswordValid(controller.text);
    bool isMatching = controller == _confirmPasswordController
        ? _passwordController.text == _confirmPasswordController.text
        : true;
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
                  message: isValid && isMatching
                      ? 'Valid'
                      : 'Password must be at least 8 characters with letters, numbers, and special characters.',
                  child: Icon(
                    isValid && isMatching ? Icons.check_circle : Icons.cancel,
                    color: isValid && isMatching
                        ? Color(0xFF3AB8B5)
                        : Color(0xFFFFC107), // Teal for valid, Yellow for invalid
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
                        'Sign Up',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1A2E44), // Dark Blue for contrast
                        ),
                      ),
                      SizedBox(height: 20),
                      SizedBox(
                        width: 400,
                        child: TextField(
                          controller: _userController,
                          decoration: InputDecoration(
                            labelText: 'User Name',
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
                          onChanged: (_) => _validateForm(),
                        ),
                      ),
                      SizedBox(height: 20),
                      SizedBox(
                        width: 400,
                        child: TextField(
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
                          onChanged: (_) => _validateForm(),
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
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'User Type',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1A2E44), // Dark Blue
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Radio<String>(
                                value: 'User',
                                groupValue: _userType,
                                onChanged: (value) {
                                  setState(() {
                                    _userType = value!;
                                  });
                                },
                                activeColor: Color(0xFF3AB8B5), // Teal/Cyan
                              ),
                              Text(
                                'User',
                                style: TextStyle(color: Color(0xFF1A2E44)), // Dark Blue
                              ),
                              SizedBox(width: 20),
                              Radio<String>(
                                value: 'Consultant',
                                groupValue: _userType,
                                onChanged: (value) {
                                  setState(() {
                                    _userType = value!;
                                  });
                                },
                                activeColor: Color(0xFF3AB8B5), // Teal/Cyan
                              ),
                              Text(
                                'Consultant',
                                style: TextStyle(color: Color(0xFF1A2E44)), // Dark Blue
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      if (_errorMessage.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text(
                            _errorMessage,
                            style: TextStyle(color: Color(0xFFFFC107), fontSize: 14), // Yellow for visibility
                          ),
                        ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _isSignUpEnabled ? _signUp : null,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                          textStyle: const TextStyle(fontSize: 18),
                          backgroundColor: Color(0xFF3AB8B5), // Teal/Cyan
                          foregroundColor: Color(0xFFFFFFFF), // White text/icons
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text('Sign Up'),
                      ),
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
  final String userType;
  const ValidatePopup({required this.email, required this.userType, Key? key}) : super(key: key);

  @override
  _ValidatePopupState createState() => _ValidatePopupState();
}

class _ValidatePopupState extends State<ValidatePopup> {
  final TextEditingController _codeController = TextEditingController();
  final authController = EmailAuthController(client.modules.auth);
  bool _isValidateEnabled = false;
  String _errorMessage = '';

  void _validateForm() {
    setState(() {
      _isValidateEnabled = _codeController.text.isNotEmpty;
    });
  }

  Future<void> _validate() async {
    if (!_isValidateEnabled) return;

    try {
      // Validate the account
      var sessionUser = await authController.validateAccount(widget.email, _codeController.text);

      // Fetch the authenticated user
      if (sessionUser == null) {
        setState(() {
          _errorMessage = 'Failed to retrieve user data.';
        });
        return;
      }

      // Create a new user in the custom table
      var newUser = UserProfile(
        userId: sessionUser.id ?? 0, // Relates to serverpod_user_info
        role: widget.userType, // Use the userType passed from SignUpPage
        fullName: sessionUser.userName ?? "name",
        nickname: sessionUser.userName ?? "name",
        dateOfBirth: DateTime.now(), // Default value
        gender: "Not specified", // Default, update as needed
        profileImage: null, // Can be updated later
        country: "Not specified", // Update with actual user input
        languages: [], // Update with actual user input
        timezone: "UTC", // Default value
        creditCardInfo: null, // Can be updated later
        educationLevel: null, // Can be updated later
        hourlyRate: null, // Relevant for consultants
      );

      // Call the backend endpoint to insert user
      await client.user.createUserProfile(newUser);

      // Navigate to login page after successful validation and insertion
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    } catch (e) {
      setState(() {
        _errorMessage = 'Error validating account: $e';
      });
    }
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
                onChanged: (_) => _validateForm(),
              ),
            ),
            SizedBox(height: 20),
            if (_errorMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  _errorMessage,
                  style: TextStyle(color: Color(0xFFFFC107), fontSize: 14), // Yellow for visibility
                ),
              ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isValidateEnabled ? _validate : null,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                textStyle: const TextStyle(fontSize: 18),
                backgroundColor: Color(0xFF3AB8B5), // Teal/Cyan
                foregroundColor: Color(0xFFFFFFFF), // White text/icons
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text('Validate Account'),
            ),
          ],
        ),
      ),
    );
  }
}