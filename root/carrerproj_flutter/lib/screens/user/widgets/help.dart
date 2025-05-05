import 'package:flutter/material.dart';

class HelpPage extends StatefulWidget {
  @override
  _HelpPageState createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  final TextEditingController _complaintController = TextEditingController();
  String? _selectedComplaintType;
  final List<String> _complaintTypes = [
    "Select Complaint Type",
    "Billing Issue",
    "Technical Issue",
    "Service Issue",
    "Other"
  ];

  @override
  void initState() {
    super.initState();
    _selectedComplaintType = _complaintTypes[0];
    _complaintController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _complaintController.dispose();
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
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10, spreadRadius: 2)],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Complaints",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF1A2E44)),
              ),
              SizedBox(height: 10),
              Text(
                "This is where you lodge a complaint",
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              ),
              SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextField(
                              controller: _complaintController,
                              maxLines: 5,
                              maxLength: 300,
                              decoration: InputDecoration(
                                hintText: "Provide a brief explanation of the complaint.",
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Color(0xFF3AB8B5))),
                                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Color(0xFF3AB8B5))),
                                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Color(0xFF3AB8B5))),
                              ),
                              style: TextStyle(color: Color(0xFF1A2E44)),
                            ),
                            SizedBox(height: 10),
                            Text(
                              "${_complaintController.text.length}/300",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                          child: DropdownButton<String>(
                            value: _selectedComplaintType,
                            items: _complaintTypes.map((String type) {
                              return DropdownMenuItem<String>(
                                value: type,
                                child: Text(type, style: TextStyle(color: Color(0xFF1A2E44))),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                _selectedComplaintType = newValue;
                              });
                            },
                            underline: SizedBox(),
                            dropdownColor: Colors.white,
                            style: TextStyle(color: Color(0xFF1A2E44)),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          if (_complaintController.text.isEmpty || _selectedComplaintType == _complaintTypes[0]) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Please fill in all fields", style: TextStyle(color: Color(0xFF1A2E44)))),
                            );
                            return;
                          }
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Complaint lodged successfully", style: TextStyle(color: Color(0xFF1A2E44)))),
                          );
                          setState(() {
                            _complaintController.clear();
                            _selectedComplaintType = _complaintTypes[0];
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF3AB8B5),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                          child: Text("Lodge Complaint"),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}