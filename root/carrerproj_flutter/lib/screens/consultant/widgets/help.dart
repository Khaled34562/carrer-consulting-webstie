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
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Complaints",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Text(
            "This is where you lodge a complaint",
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
          SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Complaint Text Field
              Expanded(
                child: Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
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
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "${_complaintController.text.length}/300",
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(width: 16),
              // Complaint Type and Button
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      child: DropdownButton<String>(
                        value: _selectedComplaintType,
                        items: _complaintTypes.map((String type) {
                          return DropdownMenuItem<String>(
                            value: type,
                            child: Text(type),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedComplaintType = newValue;
                          });
                        },
                        underline: SizedBox(),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (_complaintController.text.isEmpty ||
                          _selectedComplaintType == _complaintTypes[0]) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Please fill in all fields")),
                        );
                        return;
                      }
                      // Placeholder for lodging complaint
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Complaint lodged successfully")),
                      );
                      setState(() {
                        _complaintController.clear();
                        _selectedComplaintType = _complaintTypes[0];
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
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
    );
  }
}