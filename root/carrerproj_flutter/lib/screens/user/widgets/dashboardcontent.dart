import 'package:flutter/material.dart';

class DashboardContent extends StatelessWidget {
  final String title;

  const DashboardContent({super.key, required this.title});

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
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  const SizedBox(height: 20),
                  const Text(
                    "Today's Sessions",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF1A2E44)),
                  ),
                  blankSection(),
                  const SizedBox(height: 20),
                  const Text(
                    "Latest Messages",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF1A2E44)),
                  ),
                  blankSection(),
                  const SizedBox(height: 20),
                  const Text(
                    "Latest Reviews",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF1A2E44)),
                  ),
                  blankSection(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget blankSection() {
    return Container(
      height: 100,
      width: double.infinity,
      margin: const EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.2), blurRadius: 5)],
      ),
    );
  }
}