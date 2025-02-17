import 'package:flutter/material.dart';

class DashboardContent extends StatelessWidget {
  final String title;

  const DashboardContent({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
                children: [
                  /// Top Bar with Search and Avatar
                  Row(
                    children: [
                      /// Search Bar
                      Expanded(
                        child: Container(
                          height: 40,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Row(
                            children: [
                              Icon(Icons.search, color: Colors.grey),
                              SizedBox(width: 10),
                              Text("Search...", style: TextStyle(color: Colors.grey)),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),

                      /// Notification Icon
                      Icon(Icons.notifications_none, color: Colors.grey[700]),
                      const SizedBox(width: 20),

                      /// User Avatar Placeholder
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.grey[400], // Placeholder
                        child: Icon(Icons.person, color: Colors.white),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

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