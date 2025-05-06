import 'package:flutter/material.dart';

class PaymentsPage extends StatefulWidget {
  @override
  _PaymentsPageState createState() => _PaymentsPageState();
}

class _PaymentsPageState extends State<PaymentsPage> {
  bool _is2FAEnabled = true; // State for 2FA toggle
  String _selectedRefundMethod = 'Visa ending in 1234'; // Default refund method

  // Mock list of refund methods
  final List<String> _refundMethods = [
    'Visa ending in 1234',
    'MasterCard ending in 5678',
    'PayPal (example@email.com)',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F8F8), // Grey background
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
              Row(
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
                            Text("Add Card", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1A2E44))),
                            SizedBox(height: 10),
                            ElevatedButton(
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("Add Card functionality coming soon!", style: TextStyle(color: Color(0xFF1A2E44)))),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFF3AB8B5),
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              ),
                              child: Text("Add a Card"),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Pending Payments", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1A2E44))),
                            SizedBox(height: 10),
                            Text("\$0.00", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF1A2E44))),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
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
                            Text("Security", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1A2E44))),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Icon(Icons.lock, color: Color(0xFF3AB8B5)),
                                SizedBox(width: 10),
                                Text("2FA Enabled", style: TextStyle(color: Color(0xFF1A2E44))),
                                Spacer(),
                                Switch(
                                  value: _is2FAEnabled,
                                  onChanged: (value) {
                                    setState(() {
                                      _is2FAEnabled = value;
                                    });
                                  },
                                  activeColor: Color(0xFF3AB8B5),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            ElevatedButton(
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("Change 2FA settings coming soon!", style: TextStyle(color: Color(0xFF1A2E44)))),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey[200],
                                foregroundColor: Color(0xFF1A2E44),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              ),
                              child: Text("Change"),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Refund Method", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1A2E44))),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Icon(Icons.credit_card, color: Color(0xFF3AB8B5)),
                                SizedBox(width: 10),
                                Expanded(
                                  child: DropdownButton<String>(
                                    value: _selectedRefundMethod,
                                    isExpanded: true,
                                    items: _refundMethods.map((String method) {
                                      return DropdownMenuItem<String>(
                                        value: method,
                                        child: Text(method, style: TextStyle(color: Color(0xFF1A2E44))),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        _selectedRefundMethod = newValue!;
                                      });
                                    },
                                    underline: SizedBox(),
                                    dropdownColor: Colors.white,
                                    style: TextStyle(color: Color(0xFF1A2E44)),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            ElevatedButton(
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("Refund method updated!", style: TextStyle(color: Color(0xFF1A2E44)))),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFF3AB8B5),
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              ),
                              child: Text("Save"),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Expanded(
                child: Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Payment History", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1A2E44))),
                        SizedBox(height: 10),
                        Expanded(
                          child: ListView(
                            children: [
                              ListTile(
                                leading: Icon(Icons.history, color: Color(0xFF3AB8B5)),
                                title: Text("No payment history available", style: TextStyle(color: Color(0xFF1A2E44))),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}