import 'package:flutter/material.dart';
import 'package:serverpod_auth_shared_flutter/serverpod_auth_shared_flutter.dart';
import 'package:carrerproj_flutter/screens/login.dart';
import 'package:carrerproj_flutter/src/serverpod_client.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

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
          child: Container(
            padding: const EdgeInsets.all(16),
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
            child: ListView(
              shrinkWrap: true,
              children: [
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  leading: CircularUserImage(
                    userInfo: sessionManager.signedInUser,
                    size: 42,
                  ),
                  title: Text(
                    sessionManager.signedInUser!.userName!,
                    style: TextStyle(color: Color(0xFF1A2E44)), // Dark Blue
                  ),
                  subtitle: Text(
                    sessionManager.signedInUser!.email ?? '',
                    style: TextStyle(color: Color(0xFF1A2E44)), // Dark Blue
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: ElevatedButton(
                    onPressed: () {
                      sessionManager.signOut();
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      textStyle: const TextStyle(fontSize: 18),
                      backgroundColor: Color(0xFF3AB8B5), // Teal/Cyan
                      foregroundColor: Color(0xFFFFFFFF), // White text/icons
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text('Sign out'),
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