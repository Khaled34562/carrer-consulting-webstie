import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:carrerproj_flutter/src/serverpod_client.dart';

class ProfileContent extends StatefulWidget {
  @override
  _ProfileContentState createState() => _ProfileContentState();
}

class _ProfileContentState extends State<ProfileContent> {
  bool isEditing = false;

  // Controllers for text fields
  TextEditingController fullNameController = TextEditingController();
  TextEditingController nickNameController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController languageController = TextEditingController();
  TextEditingController timeZoneController = TextEditingController();
  TextEditingController eduController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProfileHeader(),
                  SizedBox(height: 20),
                  ProfileForm(
                    isEditing: isEditing,
                    fullNameController: fullNameController,
                    nickNameController: nickNameController,
                    genderController: genderController,
                    countryController: countryController,
                    languageController: languageController,
                    timeZoneController: timeZoneController,
                    eduController: eduController,
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        isEditing = !isEditing;
                      });
                    },
                    child: Text(isEditing ? 'Save' : 'Edit'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileHeader extends StatefulWidget {
  @override
  _ProfileHeaderState createState() => _ProfileHeaderState();
}

class _ProfileHeaderState extends State<ProfileHeader> {
  File? _image;
  String? _imagePath;

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        _imagePath = pickedFile.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Stack(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundColor: Colors.grey[400], // Placeholder
              backgroundImage: _imagePath != null ? FileImage(File(_imagePath!)) : null,
              child: _imagePath == null ? Icon(Icons.person, color: Colors.white) : null,
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: InkWell(
                onTap: _pickImage,
                child: CircleAvatar(
                  radius: 15,
                  backgroundColor: Colors.blue,
                  child: Icon(
                    Icons.camera_alt,
                    color: Colors.white,
                    size: 15,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              sessionManager.signedInUser!.userName!,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(sessionManager.signedInUser!.email ?? ''),
          ],
        ),
      ],
    );
  }
}

class ProfileForm extends StatelessWidget {
  final bool isEditing;
  final TextEditingController fullNameController;
  final TextEditingController nickNameController;
  final TextEditingController genderController;
  final TextEditingController countryController;
  final TextEditingController languageController;
  final TextEditingController timeZoneController;
  final TextEditingController eduController;

  ProfileForm({
    required this.isEditing,
    required this.fullNameController,
    required this.nickNameController,
    required this.genderController,
    required this.countryController,
    required this.languageController,
    required this.timeZoneController,
    required this.eduController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: fullNameController,
          enabled: isEditing,
          decoration: InputDecoration(labelText: 'Full Name'),
        ),
        SizedBox(height: 20),
        TextField(
          controller: nickNameController,
          enabled: isEditing,
          decoration: InputDecoration(labelText: 'Nick Name'),
        ),
        SizedBox(height: 20),
        TextField(
          controller: genderController,
          enabled: isEditing,
          decoration: InputDecoration(labelText: 'Gender'),
        ),
        SizedBox(height: 20),
        TextField(
          controller: countryController,
          enabled: isEditing,
          decoration: InputDecoration(labelText: 'Country'),
        ),
        SizedBox(height: 20),
        TextField(
          controller: languageController,
          enabled: isEditing,
          decoration: InputDecoration(labelText: 'Language'),
        ),
        SizedBox(height: 20),
        TextField(
          controller: timeZoneController,
          enabled: isEditing,
          decoration: InputDecoration(labelText: 'Time Zone'),
        ),
        SizedBox(height: 20),
        TextField(
          controller: eduController,
          enabled: isEditing,
          decoration: InputDecoration(labelText: 'Education Level'),
        ),
      ],
    );
  }
}

