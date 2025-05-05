import 'package:carrerproj_client/carrerproj_client.dart';
import 'package:carrerproj_flutter/src/serverpod_client.dart';
import 'package:flutter/material.dart';

class ProfileContent extends StatefulWidget {
  const ProfileContent({Key? key}) : super(key: key);

  @override
  _ProfileContentState createState() => _ProfileContentState();
}

class _ProfileContentState extends State<ProfileContent> {
  UserProfile? _userProfile;
  bool _isLoading = true;
  bool _isEditing = false;

  // Controllers for editable fields
  late TextEditingController _fullNameController;
  late TextEditingController _nicknameController;
  late TextEditingController _emailController;
  String? _role;

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    try {
      final userId = sessionManager.signedInUser!.id!;
      final profile = await client.user.getUserProfile(userId);
      setState(() {
        _userProfile = profile;
        _fullNameController = TextEditingController(text: profile?.fullName ?? '');
        _nicknameController = TextEditingController(text: profile?.nickname ?? '');
        _emailController = TextEditingController(text: sessionManager.signedInUser?.email ?? '');
        _role = profile?.role;
        _isLoading = false;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to load profile: $e", style: TextStyle(color: Color(0xFF1A2E44)))),
      );
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _saveProfile() async {
    if (_userProfile == null) return;
    try {
      final updatedProfile = _userProfile!.copyWith(
        fullName: _fullNameController.text,
        nickname: _nicknameController.text,
      );
      await client.user.updateUserProfile(updatedProfile);
      setState(() {
        _userProfile = updatedProfile;
        _isEditing = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Profile updated successfully!", style: TextStyle(color: Color(0xFF1A2E44)))),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to update profile: $e", style: TextStyle(color: Color(0xFF1A2E44)))),
      );
    }
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _nicknameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F8F8), // Grey background
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF1A2E44), Color(0xFF3AB8B5)],
              stops: [0.0, 0.7],
            ),
          ),
        ),
        title: Image.asset('lib/assets/white_logo.png', height: 50),
        actions: [
          if (!_isLoading && _userProfile != null)
            IconButton(
              icon: Icon(_isEditing ? Icons.save : Icons.edit, color: Colors.white),
              onPressed: () {
                if (_isEditing) {
                  _saveProfile();
                } else {
                  setState(() {
                    _isEditing = true;
                  });
                }
              },
            ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10, spreadRadius: 2)],
        ),
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : _userProfile == null
                ? Center(child: Text("Unable to load profile.", style: TextStyle(color: Color(0xFF1A2E44))))
                : SingleChildScrollView(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Stack(
                            children: [
                              CircleAvatar(
                                radius: 50,
                                backgroundColor: Color(0xFF3AB8B5),
                                child: Icon(Icons.person, size: 60, color: Colors.white),
                              ),
                              if (_isEditing)
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: CircleAvatar(
                                    radius: 20,
                                    backgroundColor: Color(0xFF3AB8B5),
                                    child: IconButton(
                                      icon: Icon(Icons.camera_alt, color: Colors.white, size: 20),
                                      onPressed: () {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(content: Text("Profile picture upload coming soon!", style: TextStyle(color: Color(0xFF1A2E44)))),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          "Full Name",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF1A2E44)),
                        ),
                        SizedBox(height: 8),
                        TextField(
                          controller: _fullNameController,
                          enabled: _isEditing,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Color(0xFF3AB8B5)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Color(0xFF3AB8B5)),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.grey.shade300),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Color(0xFF3AB8B5)),
                            ),
                          ),
                          style: TextStyle(color: Color(0xFF1A2E44)),
                        ),
                        SizedBox(height: 20),
                        Text(
                          "Nickname",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF1A2E44)),
                        ),
                        SizedBox(height: 8),
                        TextField(
                          controller: _nicknameController,
                          enabled: _isEditing,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Color(0xFF3AB8B5)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Color(0xFF3AB8B5)),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.grey.shade300),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Color(0xFF3AB8B5)),
                            ),
                          ),
                          style: TextStyle(color: Color(0xFF1A2E44)),
                        ),
                        SizedBox(height: 20),
                        Text(
                          "Email",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF1A2E44)),
                        ),
                        SizedBox(height: 8),
                        TextField(
                          controller: _emailController,
                          enabled: false, // Email is typically not editable
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.grey.shade300),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.grey.shade300),
                            ),
                          ),
                          style: TextStyle(color: Color(0xFF1A2E44)),
                        ),
                        SizedBox(height: 20),
                        Text(
                          "Role",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF1A2E44)),
                        ),
                        SizedBox(height: 8),
                        Text(
                          _role ?? 'N/A',
                          style: TextStyle(fontSize: 16, color: Color(0xFF1A2E44)),
                        ),
                        SizedBox(height: 20),
                        if (_isEditing)
                          Center(
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  _isEditing = false;
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              ),
                              child: Text("Cancel"),
                            ),
                          ),
                      ],
                    ),
                  ),
      ),
    );
  }
}