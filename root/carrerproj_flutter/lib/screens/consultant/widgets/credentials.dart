import 'dart:convert'; // For JSON parsing
import 'dart:typed_data';
import 'package:carrerproj_client/carrerproj_client.dart';
import 'package:carrerproj_flutter/src/serverpod_client.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class CredentialsPage extends StatefulWidget {
  @override
  _CredentialsPageState createState() => _CredentialsPageState();
}

class _CredentialsPageState extends State<CredentialsPage> {
  List<Credentials> _credentials = [];
  bool _isLoading = true;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _issuerController = TextEditingController();
  TextEditingController _issueDateController = TextEditingController();
  TextEditingController _expiryDateController = TextEditingController();
  String? _fileName; // Store the file name for display
  String? _filePath; // Store the file path (for mobile/desktop)
  Uint8List? _fileBytes; // Store the file bytes (for web)
  String? _uploadDescription;

  @override
  void initState() {
    super.initState();
    _fetchCredentials();
  }

  Future<void> _fetchCredentials() async {
    try {
      final userID = await sessionManager.signedInUser!.id;
      final credentials = await client.credentials.getCredentialsByUserId(userID!);
      setState(() {
        _credentials = credentials;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error fetching credentials: $e", style: TextStyle(color: Color(0xFF1A2E44)))),
      );
    }
  }

  Future<void> _deleteCredential(Credentials credential) async {
    try {
      await client.credentials.deleteCredential(credential);
      _fetchCredentials();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error deleting credential: $e", style: TextStyle(color: Color(0xFF1A2E44)))),
      );
    }
  }

  Future<void> _uploadFile(String uploadDescription, Uint8List fileBytes) async {
    try {
      print("Raw upload description: $uploadDescription");
      print("File content size: ${fileBytes.length} bytes");

      String? uploadUrl;

      if (uploadDescription.startsWith('{')) {
        final description = uploadDescription.replaceAllMapped(
            RegExp(r'curl\s+"([^"]+)"'), (match) => '"url":"${match[1]}"');
        final parsedDescription = jsonDecode(description) as Map<String, dynamic>;

        uploadUrl = parsedDescription['url'] as String?;

        if (uploadUrl == null) {
          throw Exception("Upload URL not found in description");
        }

        print("Parsed upload URL: $uploadUrl");
      } else {
        uploadUrl = uploadDescription;
        print("Using upload URL directly: $uploadUrl");
      }

      print("Uploading file to: $uploadUrl");
      final response = await http.put(
        Uri.parse(uploadUrl),
        body: fileBytes,
      );

      print("Upload response status: ${response.statusCode}");
      print("Upload response body: ${response.body}");

      if (response.statusCode != 200) {
        throw Exception("Failed to upload file: ${response.statusCode} - ${response.body}");
      }
    } catch (e) {
      print("Upload error: $e");
      throw Exception("Error uploading file: $e");
    }
  }

  Future<void> _pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'jpg', 'png'],
      );
      if (result != null && result.files.isNotEmpty) {
        final fileName = result.files.single.name;
        print("Selected file name: $fileName");
        print("File picker result: ${result.files.single.toString()}");
        print("Is web platform: $kIsWeb");

        setState(() {
          _fileName = fileName;
          if (kIsWeb) {
            _fileBytes = result.files.single.bytes;
            _filePath = null;
            print("File bytes length: ${_fileBytes?.length ?? 0} bytes");
            if (_fileBytes == null || _fileBytes!.isEmpty) {
              throw Exception("File bytes are empty or null");
            }
          } else {
            _filePath = result.files.single.path;
            _fileBytes = null;
            print("File path: $_filePath");
            if (_filePath == null || _filePath!.isEmpty) {
              throw Exception("File path is empty or null");
            }
          }
        });

        try {
          _uploadDescription = await client.credentials.getUploadDescription(fileName);
          if (_uploadDescription == null) {
            throw Exception("Failed to get upload description");
          }

          print("Upload description: $_uploadDescription");

          if (kIsWeb && _fileBytes != null) {
            await _uploadFile(_uploadDescription!, _fileBytes!);
          } else if (!kIsWeb && _filePath != null) {
            throw UnimplementedError("Mobile file upload not implemented in this example");
          } else {
            throw Exception("No file data available to upload");
          }

          final uploadSuccess = await client.credentials.verifyUpload(fileName);
          if (!uploadSuccess) {
            throw Exception("File upload verification failed");
          }
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Error preparing file upload: $e", style: TextStyle(color: Color(0xFF1A2E44)))),
          );
          setState(() {
            _fileName = null;
            _filePath = null;
            _fileBytes = null;
          });
        }
      } else {
        print("No file selected");
      }
    } catch (e) {
      print("Error in _pickFile: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error selecting file: $e", style: TextStyle(color: Color(0xFF1A2E44)))),
      );
    }
  }

  Future<void> _selectDate(BuildContext context, TextEditingController controller) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        controller.text = DateFormat('MM/dd/yyyy').format(picked);
      });
    }
  }

  Future<void> _uploadCredential() async {
    print("Credential Name: ${_nameController.text}");
    print("Issuer: ${_issuerController.text}");
    print("Issue Date: ${_issueDateController.text}");
    print("Expiry Date: ${_expiryDateController.text}");
    print("File Name: $_fileName");

    if (_nameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please enter the credential name", style: TextStyle(color: Color(0xFF1A2E44)))),
      );
      return;
    }
    if (_issuerController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please enter the issuing institution", style: TextStyle(color: Color(0xFF1A2E44)))),
      );
      return;
    }
    if (_issueDateController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please select the issue date", style: TextStyle(color: Color(0xFF1A2E44)))),
      );
      return;
    }
    if (_fileName == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please select a file", style: TextStyle(color: Color(0xFF1A2E44)))),
      );
      return;
    }

    try {
      Credentials newCredential = Credentials(
        userId: sessionManager.signedInUser!.id ?? 0,
        name: _nameController.text,
        issuer: _issuerController.text,
        version: "1.0",
        date: DateFormat('MM/dd/yyyy').parse(_issueDateController.text),
        expirationDate: _expiryDateController.text.isNotEmpty
            ? DateFormat('MM/dd/yyyy').parse(_expiryDateController.text) : null,
        fileUrl: "", // Will be set by the endpoint
        filePath: _fileName!, // Use fileName as the path for the endpoint
        status: "Pending",
      );

      await client.credentials.createCredentialWithFile(newCredential, _fileName!);
      _fetchCredentials();

      setState(() {
        _nameController.clear();
        _issuerController.clear();
        _issueDateController.clear();
        _expiryDateController.clear();
        _fileName = null;
        _filePath = null;
        _fileBytes = null;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Credential uploaded successfully", style: TextStyle(color: Color(0xFF1A2E44)))),
      );
    } catch (e) {
      print("Error in _uploadCredential: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error uploading credential: $e", style: TextStyle(color: Color(0xFF1A2E44)))),
      );
    }
  }

  Future<void> _viewDocument(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Could not open document", style: TextStyle(color: Color(0xFF1A2E44)))),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F8F8),
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
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10, spreadRadius: 2)],
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Educational Credentials",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1A2E44)),
              ),
              const SizedBox(height: 10),
              _isLoading
                  ? Center(child: CircularProgressIndicator())
                  : _credentials.isEmpty
                      ? Center(child: Text("No credentials found", style: TextStyle(color: Color(0xFF1A2E44))))
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: _credentials.length,
                          itemBuilder: (context, index) {
                            final credential = _credentials[index];
                            return Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              child: Card(
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: ListTile(
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                  title: Text(
                                    credential.name,
                                    style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1A2E44)),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(credential.issuer ?? "Unknown Issuer", style: TextStyle(color: Color(0xFF1A2E44))),
                                      Text("Issued: ${credential.date.toLocal().toString().split(' ')[0]}", style: TextStyle(color: Color(0xFF1A2E44))),
                                      Row(
                                        children: [
                                          Text(
                                            "Status: ${credential.status ?? 'Pending'}",
                                            style: TextStyle(
                                              color: credential.status == 'Verified' ? Colors.green : Colors.orange,
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          if (credential.status == 'Verified')
                                            const Icon(Icons.verified, color: Colors.green, size: 16),
                                          if (credential.status == 'Pending')
                                            const Icon(Icons.hourglass_empty, color: Colors.orange, size: 16),
                                        ],
                                      ),
                                    ],
                                  ),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TextButton(
                                        onPressed: () => _viewDocument(credential.fileUrl),
                                        child: Text("View Document", style: TextStyle(color: Color(0xFF3AB8B5))),
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.delete, color: Colors.red),
                                        onPressed: () => _deleteCredential(credential),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
              const SizedBox(height: 20),
              Text(
                "Upload New Credential",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1A2E44)),
              ),
              const SizedBox(height: 10),
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: _pickFile,
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            border: Border.all(color: Color(0xFF3AB8B5)),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              Icon(Icons.upload_file, size: 40, color: Color(0xFF3AB8B5)),
                              const SizedBox(height: 8),
                              Text(
                                _fileName != null
                                    ? "File selected: $_fileName"
                                    : "Drag and drop your credential document here",
                                style: TextStyle(color: Color(0xFF1A2E44)),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                "Supported formats: PDF, JPG, PNG (max 10MB)",
                                style: TextStyle(color: Colors.grey.shade500, fontSize: 12),
                              ),
                              const SizedBox(height: 8),
                              ElevatedButton(
                                onPressed: _pickFile,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xFF3AB8B5),
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: Text("Browse Files"),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          labelText: "Credential Name",
                          labelStyle: TextStyle(color: Color(0xFF1A2E44)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Color(0xFF3AB8B5)),
                          ),
                        ),
                        style: TextStyle(color: Color(0xFF1A2E44)),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: _issuerController,
                        decoration: InputDecoration(
                          labelText: "Issuing Institution",
                          labelStyle: TextStyle(color: Color(0xFF1A2E44)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Color(0xFF3AB8B5)),
                          ),
                        ),
                        style: TextStyle(color: Color(0xFF1A2E44)),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: _issueDateController,
                        decoration: InputDecoration(
                          labelText: "Issue Date (MM/DD/YYYY)",
                          labelStyle: TextStyle(color: Color(0xFF1A2E44)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Color(0xFF3AB8B5)),
                          ),
                        ),
                        readOnly: true,
                        onTap: () => _selectDate(context, _issueDateController),
                        style: TextStyle(color: Color(0xFF1A2E44)),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: _expiryDateController,
                        decoration: InputDecoration(
                          labelText: "Expiry Date (MM/DD/YYYY)",
                          labelStyle: TextStyle(color: Color(0xFF1A2E44)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Color(0xFF3AB8B5)),
                          ),
                        ),
                        readOnly: true,
                        onTap: () => _selectDate(context, _expiryDateController),
                        style: TextStyle(color: Color(0xFF1A2E44)),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: _uploadCredential,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF3AB8B5),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          minimumSize: const Size(double.infinity, 50),
                        ),
                        child: Text("Upload Credential", style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "Verification Status",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1A2E44)),
              ),
              const SizedBox(height: 10),
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    ListTile(
                      title: Text("Verified", style: TextStyle(color: Color(0xFF1A2E44))),
                      trailing: Text(
                        "${_credentials.where((c) => c.status == 'Verified').length}",
                        style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1A2E44)),
                      ),
                      tileColor: Colors.green.shade50,
                    ),
                    ListTile(
                      title: Text("Pending", style: TextStyle(color: Color(0xFF1A2E44))),
                      trailing: Text(
                        "${_credentials.where((c) => c.status == 'Pending' || c.status == null).length}",
                        style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1A2E44)),
                      ),
                      tileColor: Colors.orange.shade50,
                    ),
                    ListTile(
                      title: Text("Total", style: TextStyle(color: Color(0xFF1A2E44))),
                      trailing: Text(
                        "${_credentials.length}",
                        style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1A2E44)),
                      ),
                      tileColor: Colors.grey.shade100,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}