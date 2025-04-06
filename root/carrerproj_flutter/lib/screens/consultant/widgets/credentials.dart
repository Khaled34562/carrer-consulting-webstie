import 'package:carrerproj_client/carrerproj_client.dart';
import 'package:carrerproj_flutter/src/serverpod_client.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
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
  String? _filePath;

  @override
  void initState() {
    super.initState();
    _fetchCredentials();
  }

  Future<void> _fetchCredentials() async {
    final userID = await sessionManager.signedInUser!.id;
    final credentials = await client.credentials.getCredentialsByUserId(userID!);
    setState(() {
      _credentials = credentials;
      _isLoading = false;
    });
  }

  void _deleteCredential(Credentials credential) async {
    await client.credentials.deleteCredential(credential);
    _fetchCredentials();
  }

  void _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        _filePath = result.files.single.name;
      });
    }
  }

  void _selectDate(BuildContext context, TextEditingController controller) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        controller.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  void _uploadCredential() async {
    if (_nameController.text.isEmpty || _issuerController.text.isEmpty || _filePath == null) {
      return;
    }
    Credentials newCredential = Credentials(
      userId: sessionManager.signedInUser!.id ?? 0,
      name: _nameController.text,
      issuer: _issuerController.text,
      version: "1.0",
      date: DateTime.parse(_issueDateController.text),
      expirationDate: _expiryDateController.text.isNotEmpty ? DateTime.parse(_expiryDateController.text) : null,
      fileUrl: _filePath!,
      filePath: _filePath!,
      status: "Pending",
    );
    await client.credentials.createCredential(newCredential);
    _fetchCredentials();
  }

  void _viewDocument(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Could not open document")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Educational Credentials", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          _isLoading
              ? CircularProgressIndicator()
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: _credentials.length,
                  itemBuilder: (context, index) {
                    final credential = _credentials[index];
                    return Card(
                      child: ListTile(
                        title: Text(credential.name),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(credential.issuer!),
                            Text("Issued: ${credential.date.toLocal()}"),
                            Text("Status: ${credential.status ?? 'Pending'}", style: TextStyle(color: credential.status == 'Verified' ? Colors.green : Colors.orange)),
                          ],
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextButton(
                              onPressed: () => _viewDocument(credential.fileUrl),
                              child: Text("View Document"),
                            ),
                            IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: () => _deleteCredential(credential),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
          SizedBox(height: 20),
          Text("Upload New Credential", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          GestureDetector(
            onTap: _pickFile,
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
              child: Column(
                children: [
                  Icon(Icons.upload_file),
                  Text(_filePath ?? "Drag and drop your credential document here"),
                ],
              ),
            ),
          ),
          TextField(controller: _nameController, decoration: InputDecoration(labelText: "Credential Name")),
          TextField(controller: _issuerController, decoration: InputDecoration(labelText: "Issuing Institution")),
          TextField(
            controller: _issueDateController,
            decoration: InputDecoration(labelText: "Issue Date"),
            readOnly: true,
            onTap: () => _selectDate(context, _issueDateController),
          ),
          TextField(
            controller: _expiryDateController,
            decoration: InputDecoration(labelText: "Expiry Date"),
            readOnly: true,
            onTap: () => _selectDate(context, _expiryDateController),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: _uploadCredential,
            child: Text("Upload Credential"),
          ),
          SizedBox(height: 20),
          Text("Verification Status", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          Card(
            child: Column(
              children: [
                ListTile(
                  title: Text("Verified"),
                  trailing: Text("${_credentials.where((c) => c.status == 'Verified').length}"),
                  tileColor: Colors.green.shade100,
                ),
                ListTile(
                  title: Text("Pending"),
                  trailing: Text("${_credentials.where((c) => c.status == 'Pending' || c.status == null).length}"),
                  tileColor: Colors.orange.shade100,
                ),
                ListTile(
                  title: Text("Total"),
                  trailing: Text("${_credentials.length}"),
                  tileColor: Colors.grey.shade200,
                ),
              ],
            ),
          ),
        ],
      ),
      )
    );
  }
}