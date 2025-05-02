import 'package:carrerproj_client/carrerproj_client.dart';
import 'package:flutter/material.dart';
import 'package:carrerproj_flutter/src/serverpod_client.dart';
import 'package:serverpod_auth_shared_flutter/serverpod_auth_shared_flutter.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class ProfileContent extends StatefulWidget {
  @override
  _ProfileContentState createState() => _ProfileContentState();
}

class _ProfileContentState extends State<ProfileContent> {
  bool isEditing = false;
  int? _profileId;

  // Controllers for text fields
  TextEditingController fullNameController = TextEditingController();
  TextEditingController nickNameController = TextEditingController();
  TextEditingController hourlyRateController = TextEditingController();
  TextEditingController dateOfBirthController = TextEditingController();

  String? selectedGender;
  String? selectedCountry;
  List<String> selectedLanguages = [];
  String? selectedTimeZone;
  DateTime? dateOfBirth;

  final List<String> genderOptions = ['Male', 'Female'];
  final List<String> countryOptions = ['Saudi Arabia', 'USA', 'Canada', 'UK', 'India', 'Germany'];
  final List<String> languageOptions = ['Arabic', 'English', 'Spanish', 'French', 'German'];
  final List<String> timeZoneOptions = ['UTC-5', 'UTC+0', 'UTC+3', 'UTC+9'];

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    final userId = sessionManager.signedInUser!.id;
    final profile = await client.user.getUserProfile(userId!);

    if (profile != null) {
      setState(() {
        _profileId = profile.id;
        fullNameController.text = profile.fullName;
        nickNameController.text = profile.nickname;
        hourlyRateController.text = profile.hourlyRate?.toString() ?? '';
        selectedGender = genderOptions.contains(profile.gender) ? profile.gender : null;
        selectedCountry = countryOptions.contains(profile.country) ? profile.country : null;
        selectedLanguages = profile.languages.where((lang) => languageOptions.contains(lang)).toList();
        selectedTimeZone = timeZoneOptions.contains(profile.timezone) ? profile.timezone : null;
        dateOfBirth = profile.dateOfBirth;
        dateOfBirthController.text = dateOfBirth != null
            ? "${dateOfBirth!.day}/${dateOfBirth!.month}/${dateOfBirth!.year}"
            : '';
      });
    }
  }

  Future<void> _saveProfile() async {
    final userId = sessionManager.signedInUser!.id;
    final profile = await client.user.getUserProfile(userId!);

    final updatedUser = UserProfile(
      id: _profileId,
      userId: userId,
      role: profile?.role ?? 'user',
      fullName: fullNameController.text,
      nickname: nickNameController.text,
      dateOfBirth: dateOfBirth ?? DateTime.now(),
      gender: selectedGender ?? '',
      country: selectedCountry ?? '',
      languages: selectedLanguages,
      timezone: selectedTimeZone ?? '',
      hourlyRate: double.tryParse(hourlyRateController.text),
      profileImage: profile?.profileImage,
      creditCardInfo: profile?.creditCardInfo,
      educationLevel: profile?.educationLevel,
    );

    UserProfile? result;
    if (profile != null) {
      result = await client.user.updateUserProfile(updatedUser);
    } else {
      result = await client.user.createUserProfile(updatedUser);
    }

    if (result != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Profile saved successfully!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save profile.')),
      );
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: dateOfBirth ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != dateOfBirth) {
      setState(() {
        dateOfBirth = picked;
        dateOfBirthController.text = "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

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
                    ProfileHeader(sessionManager: sessionManager),
                    SizedBox(height: 20),
                    ProfileForm(
                      isEditing: isEditing,
                      fullNameController: fullNameController,
                      nickNameController: nickNameController,
                      hourlyRateController: hourlyRateController,
                      dateOfBirthController: dateOfBirthController,
                      selectedGender: selectedGender,
                      selectedCountry: selectedCountry,
                      selectedLanguages: selectedLanguages,
                      selectedTimeZone: selectedTimeZone,
                      onGenderChanged: (value) => setState(() => selectedGender = value),
                      onCountryChanged: (value) => setState(() => selectedCountry = value),
                      onLanguagesChanged: (values) => setState(() => selectedLanguages = values.cast<String>()),
                      onTimeZoneChanged: (value) => setState(() => selectedTimeZone = value),
                      onDateTap: () => _selectDate(context),
                      genderOptions: genderOptions,
                      countryOptions: countryOptions,
                      languageOptions: languageOptions,
                      timeZoneOptions: timeZoneOptions,
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async {
                        if (isEditing) {
                          await _saveProfile();
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

class ProfileHeader extends StatelessWidget {
  final SessionManager sessionManager;

  ProfileHeader({required this.sessionManager});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        UserImageButton(sessionManager: sessionManager),
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
  final TextEditingController dateOfBirthController;
  final String? selectedGender;
  final String? selectedCountry;
  final List<String> selectedLanguages;
  final String? selectedTimeZone;
  final Function(String?) onGenderChanged;
  final Function(String?) onCountryChanged;
  final void Function(List<String>) onLanguagesChanged;
  final Function(String?) onTimeZoneChanged;
  final VoidCallback onDateTap;
  final List<String> genderOptions;
  final List<String> countryOptions;
  final List<String> languageOptions;
  final List<String> timeZoneOptions;

  ProfileForm({
    required this.isEditing,
    required this.fullNameController,
    required this.nickNameController,
    required this.hourlyRateController,
    required this.dateOfBirthController,
    required this.selectedGender,
    required this.selectedCountry,
    required this.selectedLanguages,
    required this.selectedTimeZone,
    required this.onGenderChanged,
    required this.onCountryChanged,
    required this.onLanguagesChanged,
    required this.onTimeZoneChanged,
    required this.onDateTap,
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
          controller: dateOfBirthController,
          enabled: isEditing,
          readOnly: true,
          onTap: isEditing ? onDateTap : null,
          decoration: InputDecoration(
            labelText: 'Date of Birth',
            suffixIcon: Icon(Icons.calendar_today),
          ),
        ),
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
        MultiSelectDialogField(
          items: languageOptions.map((e) => MultiSelectItem<String>(e, e)).toList(),
          initialValue: selectedLanguages,
          onConfirm: onLanguagesChanged,
          title: Text('Select Languages'),
          buttonText: Text('Select Languages'),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        SizedBox(height: 20),
        DropdownButtonFormField(
          value: selectedTimeZone,
          items: timeZoneOptions.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
          onChanged: isEditing ? onTimeZoneChanged : null,
          decoration: InputDecoration(labelText: 'Time Zone'),
        ),
        SizedBox(height: 20),
        TextField(
          controller: hourlyRateController,
          enabled: isEditing,
          decoration: InputDecoration(labelText: 'Hourly Rate'),
        ),
      ],
    );
  }
}