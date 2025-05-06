import 'package:carrerproj_flutter/screens/user/widgets/dashboardcontent.dart';
import 'package:carrerproj_flutter/screens/user/widgets/profilecontent.dart';
import 'package:carrerproj_flutter/screens/user/widgets/messages.dart';
import 'package:carrerproj_flutter/screens/user/widgets/articles.dart';
import 'package:carrerproj_flutter/screens/user/widgets/payments.dart';
import 'package:carrerproj_flutter/screens/user/widgets/CVpage.dart';
import 'package:carrerproj_flutter/screens/user/widgets/help.dart';
import 'package:carrerproj_flutter/src/serverpod_client.dart';
import 'package:carrerproj_flutter/screens/landing.dart';
import 'package:flutter/material.dart';

class DashboardPageUser extends StatefulWidget {
  const DashboardPageUser({super.key});

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPageUser> {
  int _selectedIndex = 0; // Track selected tab index

  /// List of pages for each menu item
  final List<Widget> _pages = [
    const DashboardContent(title: "Dashboard Overview"),
    const DashboardContent(title: "Calendar View"),
    ProfileContent(),
    MessagesContent(),
    PaymentsPage(),
    ArticleContent(),
    CVPage(),
    HelpPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF1A2E44), // Dark Blue
                Color(0xFF3AB8B5), // Teal/Cyan
              ],
              stops: [0.0, 0.7], // Emphasize teal more
            ),
          ),
        ),
        title: Image.asset(
          'lib/assets/white_logo.png', // White logo in the header due to gradient
          height: 50, // Adjust size as needed
        ),
      ),
      backgroundColor: Color(0xFFF8F8F8), // Grey background (248, 248, 248)
      body: Column(
        children: [
          /// Search Bar, Avatar, and User Text
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                /// User Text
                Text(
                  'User',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A2E44), // Dark Blue
                  ),
                ),
                const SizedBox(width: 20),

                /// Search Bar
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Search...",
                      prefixIcon: Icon(Icons.search, color: Color(0xFF3AB8B5)), // Teal/Cyan
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Color(0xFF3AB8B5)), // Teal/Cyan
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Color(0xFF3AB8B5)), // Teal/Cyan
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Color(0xFF3AB8B5)), // Teal/Cyan
                      ),
                    ),
                    style: TextStyle(color: Color(0xFF1A2E44)), // Dark Blue text for input
                  ),
                ),
                const SizedBox(width: 20),

                /// Notification Icon
                IconButton(
                  icon: Icon(Icons.notifications_none, color: Color(0xFF3AB8B5)), // Teal/Cyan
                  onPressed: () {
                    // Handle notification click
                  },
                ),
                const SizedBox(width: 20),

                /// Sign Out Button
                TextButton.icon(
                  onPressed: () {
                    // Handle sign out
                    sessionManager.signOutDevice();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LandingPage()),
                    );
                  },
                  icon: Icon(Icons.logout, color: Color(0xFF3AB8B5)), // Teal/Cyan
                  label: Text(
                    "Sign Out",
                    style: TextStyle(color: Color(0xFF3AB8B5)), // Teal/Cyan
                  ),
                ),

                const SizedBox(width: 20),

                /// User Avatar
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Color(0xFF3AB8B5), // Teal/Cyan
                  child: const Icon(Icons.person, color: Colors.white),
                ),
              ],
            ),
          ),

          /// Main Content Row
          Expanded(
            child: Row(
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

                      /// Sidebar Tabs
                      SidebarTab(
                        icon: Icons.dashboard,
                        label: "Dashboard",
                        isSelected: _selectedIndex == 0,
                        onTap: () => setState(() => _selectedIndex = 0),
                      ),
                      SidebarTab(
                        icon: Icons.calendar_today,
                        label: "Sessions",
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
                        icon: Icons.mail,
                        label: "Messages",
                        isSelected: _selectedIndex == 3,
                        onTap: () => setState(() => _selectedIndex = 3),
                      ),
                      SidebarTab(
                        icon: Icons.payment,
                        label: "Payments",
                        isSelected: _selectedIndex == 4,
                        onTap: () => setState(() => _selectedIndex = 4),
                      ),
                      SidebarTab(
                        icon: Icons.library_books,
                        label: "Articles",
                        isSelected: _selectedIndex == 5,
                        onTap: () => setState(() => _selectedIndex = 5),
                      ),
                      SidebarTab(
                        icon: Icons.description,
                        label: "CV",
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
                        color: Colors.white, // White background for the content area
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 10,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: _pages[_selectedIndex], // Display the selected page
                      ),
                    ),
                  ),
                ),
              ],
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
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          gradient: isSelected
              ? LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF1A2E44), // Dark Blue
                    Color(0xFF3AB8B5), // Teal/Cyan
                  ],
                  stops: [0.0, 0.7],
                )
              : null,
          borderRadius: BorderRadius.circular(10),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Color(0xFF3AB8B5).withOpacity(0.3), // Teal/Cyan glow
                    blurRadius: 8,
                    spreadRadius: 2,
                    offset: Offset(0, 2),
                  ),
                ]
              : [],
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.white : Color(0xFF1A2E44), // White for selected, Dark Blue for unselected
            ),
            const SizedBox(width: 10),
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                color: isSelected ? Colors.white : Color(0xFF1A2E44), // White for selected, Dark Blue for unselected
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}