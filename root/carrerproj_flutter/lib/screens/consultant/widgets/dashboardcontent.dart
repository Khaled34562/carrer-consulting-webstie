import 'package:flutter/material.dart';

class DashboardContent extends StatelessWidget {
  final String title;

  const DashboardContent({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
                children: [

                  /// Content Sections
                  Expanded(
                    child: ListView(
                      children: [
                  const SizedBox(height: 20),
                  const Text(
                    "Today's Sessions",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  blankSection(),

                  const SizedBox(height: 20),
                  const Text(
                    "Latest Messages",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  blankSection(),

                  const SizedBox(height: 20),
                  const Text(
                    "Latest Reviews",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  blankSection(),
                ],
                    ),
                  ),
                ],
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