import 'package:carrerproj_flutter/screens/user/widgets/dashboardcontent.dart';
import 'package:carrerproj_flutter/screens/user/widgets/profilecontent.dart';
import 'package:carrerproj_flutter/screens/user/widgets/articles.dart';
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
    const DashboardContent(title: "Messages Inbox"),
    const DashboardContent(title: "Payments Transactions"),
    ArticleContent(),
    const DashboardContent(title: "Settings Panel"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Career Consulting',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.blueAccent,
          ),
        ),
      ),
      body: Column(
        children: [
    /// Search Bar, Avatar, and User Text
    Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          /// User Text
          const Text(
            'User',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent,
            ),
          ),
          const SizedBox(width: 20),

          /// Search Bar
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search...",
                prefixIcon: Icon(Icons.search, color: Colors.grey),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          const SizedBox(width: 20),

          /// Notification Icon
          IconButton(
            icon: Icon(Icons.notifications_none, color: Colors.grey[700]),
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
            icon: const Icon(Icons.logout, color: Colors.red),
            label: const Text("Sign Out", style: TextStyle(color: Colors.red)),
          ),

          const SizedBox(width: 20),

          /// User Avatar
          CircleAvatar(
            radius: 20,
            backgroundColor: Colors.grey[400],
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
                        icon: Icons.mail,
                        label: "Messages",
                        isSelected: _selectedIndex == 4,
                        onTap: () => setState(() => _selectedIndex = 3),
                      ),
                      SidebarTab(
                        icon: Icons.payment,
                        label: "Payments",
                        isSelected: _selectedIndex == 5,
                        onTap: () => setState(() => _selectedIndex = 4),
                      ),
                      SidebarTab(
                        icon: Icons.library_books,
                        label: "Articles",
                        isSelected: _selectedIndex == 6,
                        onTap: () => setState(() => _selectedIndex = 5),
                      ),
                      SidebarTab(
                        icon: Icons.settings,
                        label: "Settings",
                        isSelected: _selectedIndex == 7,
                        onTap: () => setState(() => _selectedIndex = 6),
                      ),

                      const Spacer(),

                      /// Help Button
                      SidebarTab(
                        icon: Icons.help_outline,
                        label: "Help",
                        isSelected: false,
                        onTap: () {},
                      ),
                    ],
                  ),
                ),

                /// Main Content (Updates Based on Selected Tab)
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: _pages[_selectedIndex], // Display the selected page
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
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Row(
          children: [
            Icon(icon, color: isSelected ? Colors.blueAccent : Colors.black54),
            const SizedBox(width: 10),
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                color: isSelected ? Colors.blueAccent : Colors.black87,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}