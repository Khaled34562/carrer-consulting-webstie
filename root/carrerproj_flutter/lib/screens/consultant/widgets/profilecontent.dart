import 'dart:convert';
import 'dart:typed_data';
import 'package:carrerproj_client/carrerproj_client.dart';
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
  String? _imageUrl;
  int? _profileId;

  Future<void> _loadUserProfile() async {
  final userId = sessionManager.signedInUser!.id;
  final profile = await client.user.getUserProfile(userId!);

  if (profile != null) {
    setState(() {
      _profileId = profile.id;
      fullNameController.text = profile.fullName;
      nickNameController.text = profile.nickname;
      hourlyRateController.text = profile.hourlyRate?.toString() ?? '';
      selectedGender = profile.gender;
      selectedCountry = profile.country;
      selectedLanguage = profile.languages.isNotEmpty ? profile.languages.first : null;
      selectedTimeZone = profile.timezone;
      if (profile.profileImage != null) {
        _imageUrl = profile.profileImage!;
      }
    });
  }
}

  // Controllers for text fields
  TextEditingController fullNameController = TextEditingController();
  TextEditingController nickNameController = TextEditingController();
  TextEditingController hourlyRateController = TextEditingController();

  String? selectedGender;
  String? selectedCountry;
  String? selectedLanguage;
  String? selectedTimeZone;

  final List<String> genderOptions = ['Male', 'Female'];
  final List<String> countryOptions = ['Saudi Arabia', 'USA', 'Canada', 'UK', 'India', 'Germany'];
  final List<String> languageOptions = ['Arabic', 'English', 'Spanish', 'French', 'German'];
  final List<String> timeZoneOptions = ['UTC-5', 'UTC+0', 'UTC+3', 'UTC+9'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Row(
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
                      hourlyRateController: hourlyRateController,
                      selectedGender: selectedGender,
                      selectedCountry: selectedCountry,
                      selectedLanguage: selectedLanguage,
                      selectedTimeZone: selectedTimeZone,
                      onGenderChanged: (value) => setState(() => selectedGender = value),
                      onCountryChanged: (value) => setState(() => selectedCountry = value),
                      onLanguageChanged: (value) => setState(() => selectedLanguage = value),
                      onTimeZoneChanged: (value) => setState(() => selectedTimeZone = value),
                      genderOptions: genderOptions,
                      countryOptions: countryOptions,
                      languageOptions: languageOptions,
                      timeZoneOptions: timeZoneOptions,
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async {
                        if (isEditing) {
                          final userId = sessionManager.signedInUser!.id;
                          final profile = await client.user.getUserProfile(userId!);
                          final updatedUser = UserProfile(
                            id: _profileId, // Include the ID for updating
                            userId: userId,
                            role: profile!.role,
                            fullName: fullNameController.text,
                            nickname: nickNameController.text,
                            dateOfBirth: profile.dateOfBirth,
                            gender: selectedGender ?? '',
                            country: selectedCountry ?? '',
                            languages: selectedLanguage != null
                                ? [selectedLanguage!]
                                : [],
                            timezone: selectedTimeZone ?? '',
                            hourlyRate:
                                double.tryParse(hourlyRateController.text),
                            profileImage:
                                _imageUrl, // Save the updated profile image URL
                          );

                          final result =
                              await client.user.updateUserProfile(updatedUser);
                          if (result != null) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content:
                                    Text('Profile updated successfully!')));
                          }
                        }

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
      ),
    );
  }
}

class ProfileHeader extends StatefulWidget {
  @override
  _ProfileHeaderState createState() => _ProfileHeaderState();
}

class _ProfileHeaderState extends State<ProfileHeader> {
  Uint8List? _imageBytes;
  String? _imageUrl;
  final String defaultAvatarUrl = 'https://www.example.com/default_person_icon.png';

 Future<void> _pickImage() async {
  final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
  if (pickedFile != null) {
    final bytes = await pickedFile.readAsBytes();
    final base64String = base64Encode(bytes); // Convert to base64 for storage

    setState(() {
      _imageBytes = bytes;
      _imageUrl = 'data:image/png;base64,$base64String'; // Store base64 string temporarily
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
              backgroundColor: Colors.grey[400],
              backgroundImage: _imageBytes != null
                  ? MemoryImage(_imageBytes!)
                  : (_imageUrl != null && _imageUrl!.startsWith('http'))
                      ? NetworkImage(_imageUrl!) as ImageProvider
                      : AssetImage(
                          'assets/default_avatar.png'), // Fallback image
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
  final TextEditingController hourlyRateController;
  final String? selectedGender;
  final String? selectedCountry;
  final String? selectedLanguage;
  final String? selectedTimeZone;
  final Function(String?) onGenderChanged;
  final Function(String?) onCountryChanged;
  final Function(String?) onLanguageChanged;
  final Function(String?) onTimeZoneChanged;
  final List<String> genderOptions;
  final List<String> countryOptions;
  final List<String> languageOptions;
  final List<String> timeZoneOptions;

  ProfileForm({
    required this.isEditing,
    required this.fullNameController,
    required this.nickNameController,
    required this.hourlyRateController,
    required this.selectedGender,
    required this.selectedCountry,
    required this.selectedLanguage,
    required this.selectedTimeZone,
    required this.onGenderChanged,
    required this.onCountryChanged,
    required this.onLanguageChanged,
    required this.onTimeZoneChanged,
    required this.genderOptions,
    required this.countryOptions,
    required this.languageOptions,
    required this.timeZoneOptions,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(controller: fullNameController, enabled: isEditing, decoration: InputDecoration(labelText: 'Full Name')),
        SizedBox(height: 20),
        TextField(controller: nickNameController, enabled: isEditing, decoration: InputDecoration(labelText: 'Nick Name')),
        SizedBox(height: 20),
        DropdownButtonFormField(
          value: selectedGender,
          items: genderOptions.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
          onChanged: isEditing ? onGenderChanged : null,
          decoration: InputDecoration(labelText: 'Gender'),
        ),
        SizedBox(height: 20),
        DropdownButtonFormField(
          value: selectedCountry,
          items: countryOptions.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
          onChanged: isEditing ? onCountryChanged : null,
          decoration: InputDecoration(labelText: 'Country'),
        ),
        SizedBox(height: 20),
        DropdownButtonFormField(
          value: selectedLanguage,
          items: languageOptions.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
          onChanged: isEditing ? onLanguageChanged : null,
          decoration: InputDecoration(labelText: 'Language'),
        ),
        SizedBox(height: 20),
        DropdownButtonFormField(
          value: selectedTimeZone,
          items: timeZoneOptions.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
          onChanged: isEditing ? onTimeZoneChanged : null,
          decoration: InputDecoration(labelText: 'Time Zone'),
        ),
        SizedBox(height: 20),
        TextField(controller: hourlyRateController, enabled: isEditing, decoration: InputDecoration(labelText: 'Hourly Rate')),
      ],
    );
  }
}


