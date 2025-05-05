import 'package:carrerproj_flutter/screens/consultant/widgets/dashboardcontent.dart';
import 'package:carrerproj_flutter/screens/consultant/widgets/articlecontent.dart';
import 'package:carrerproj_flutter/screens/consultant/widgets/profilecontent.dart';
import 'package:carrerproj_flutter/screens/consultant/widgets/messages.dart';
import 'package:carrerproj_flutter/screens/consultant/widgets/credentials.dart';
import 'package:carrerproj_flutter/screens/user/widgets/help.dart';
import 'package:carrerproj_flutter/screens/user/widgets/payments.dart';
import 'package:carrerproj_flutter/src/serverpod_client.dart';
import 'package:flutter/material.dart';
import 'package:carrerproj_flutter/screens/landing.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _selectedIndex = 0; // Track selected tab index

  /// List of pages for each menu item
  final List<Widget> _pages = [
    const DashboardContent(title: "Dashboard Overview"),
    const DashboardContent(title: "Calendar View"),
    ProfileContent(),
    CredentialsPage(),
    MessagesContent(),
    PaymentsPage(),
    ArticleContent(),
    HelpPage(), 
  ];

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
        title: Row(
          children: [
            Image.asset('lib/assets/white_logo.png', height: 50),
            SizedBox(width: 20),
            Text(
              'Consultant',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        actions: [
          Container(
            width: 300,
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search...",
                hintStyle: TextStyle(color: Colors.white70),
                prefixIcon: Icon(Icons.search, color: Colors.white),
                filled: true,
                fillColor: Colors.white24,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
              style: TextStyle(color: Colors.white),
            ),
          ),
          SizedBox(width: 20),
          IconButton(
            icon: Icon(Icons.notifications_none, color: Colors.white),
            onPressed: () {
              // Handle notification click
            },
          ),
          SizedBox(width: 20),
          TextButton.icon(
            onPressed: () {
              sessionManager.signOutDevice();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LandingPage()),
              );
            },
            icon: Icon(Icons.logout, color: Colors.red),
            label: Text("Sign Out", style: TextStyle(color: Colors.red)),
          ),
          SizedBox(width: 20),
          CircleAvatar(
            radius: 20,
            backgroundColor: Color(0xFF3AB8B5),
            child: Icon(Icons.person, color: Colors.white),
          ),
          SizedBox(width: 20),
        ],
      ),
      body: Row(
        children: [
          /// Sidebar Menu
          Container(
            width: 250,
            color: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30),
                SidebarTab(
                  icon: Icons.dashboard,
                  label: "Dashboard",
                  isSelected: _selectedIndex == 0,
                  onTap: () => setState(() => _selectedIndex = 0),
                ),
                SidebarTab(
                  icon: Icons.calendar_today,
                  label: "Calendar",
                  isSelected: _selectedIndex == 1,
                  onTap: () => setState(() => _selectedIndex = 1),
                ),
                SidebarTab(
                  icon: Icons.person,
                  label: "Profile",
                  isSelected: _selectedIndex == 2,
                  onTap: () => setState(() => _selectedIndex = 2),
                ),
                SidebarTab(
                  icon: Icons.article,
                  label: "Credentials",
                  isSelected: _selectedIndex == 3,
                  onTap: () => setState(() => _selectedIndex = 3),
                ),
                SidebarTab(
                  icon: Icons.mail,
                  label: "Messages",
                  isSelected: _selectedIndex == 4,
                  onTap: () => setState(() => _selectedIndex = 4),
                ),
                SidebarTab(
                  icon: Icons.payment,
                  label: "Payments",
                  isSelected: _selectedIndex == 5,
                  onTap: () => setState(() => _selectedIndex = 5),
                ),
                SidebarTab(
                  icon: Icons.library_books,
                  label: "Articles",
                  isSelected: _selectedIndex == 6,
                  onTap: () => setState(() => _selectedIndex = 6),
                ),
                const Spacer(),
                SidebarTab(
                  icon: Icons.help_outline,
                  label: "Help",
                  isSelected: _selectedIndex == 7,
                  onTap: () => setState(() => _selectedIndex = 7),
                ),
              ],
            ),
          ),
          /// Main Content (Updates Based on Selected Tab)
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10, spreadRadius: 2)],
                ),
                child: _pages[_selectedIndex], // Display the selected page
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Sidebar Menu Tab Widget
class SidebarTab extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const SidebarTab({
    super.key,
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Row(
          children: [
            Icon(icon, color: isSelected ? Color(0xFF3AB8B5) : Color(0xFF1A2E44)),
            const SizedBox(width: 10),
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                color: isSelected ? Color(0xFF3AB8B5) : Color(0xFF1A2E44),
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}