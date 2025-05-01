import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';

class CVPage extends StatefulWidget {
  @override
  _CVPageState createState() => _CVPageState();
}

class _CVPageState extends State<CVPage> {
  List<TextEditingController> controllers = List.generate(6, (_) => TextEditingController());
  List<String> labels = [
    'Name',
    'Phone number',
    'Email',
    'Skills',
    'Education',
    'Experience',
  ];
  List<String> tooltips = [
    'First name Last name, e.g John Smith',
    '+(country code)XXXXXXXXX',
    'myEmail@example.com',
    'Any soft skills or technical skills you have',
    'Where did you study and for how long?',
    'Any relevant experiences, such as projects or prior work history',
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Build a CV Section
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Build a CV',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              for (int i = 0; i < labels.length; i++)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Tooltip(
                    message: tooltips[i],
                    child: TextField(
                      controller: controllers[i],
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: labels[i],
                      ),
                    ),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: () {
                    // //ENDPOINT PLACE HOLDER
                  },
                  child: Text('Build my CV'),
                  style: ElevatedButton.styleFrom(foregroundColor: Colors.white, backgroundColor: Colors.blue),
                ),
              ),
            ],
          ),
        ),
        // Rate a CV Section
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Rate a CV',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: GestureDetector(
                  onTap: () {
                    // //FILE PICKER PLACE HOLDER
                  },
                  child: DottedBorder(
                    borderType: BorderType.RRect,
                    radius: Radius.circular(8),
                    dashPattern: [6, 3],
                    strokeWidth: 2,
                    child: Container(
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.file_upload, size: 48, color: Colors.blue),
                            SizedBox(height: 16),
                            Text('Click here to upload your file or drag'),
                            Text(
                              'Supported format: pdf, docx',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: () {
                    // //ENDPOINT PLACE HOLDER
                  },
                  child: Text('Rate my CV'),
                  style: ElevatedButton.styleFrom(foregroundColor: Colors.white, backgroundColor: Colors.blue),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}