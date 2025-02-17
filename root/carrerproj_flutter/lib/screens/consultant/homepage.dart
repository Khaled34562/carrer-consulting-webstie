import 'package:authinticationproj_flutter/screens/consultant/widgets/dashboardcontent.dart';
import 'package:authinticationproj_flutter/screens/consultant/widgets/profilecontent.dart';
import 'package:flutter/material.dart';

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
    const DashboardContent(title: "Credentials Section"),
    const DashboardContent(title: "Messages Inbox"),
    const DashboardContent(title: "Payments Transactions"),
    const DashboardContent(title: "Articles & Blogs"),
    const DashboardContent(title: "Settings Panel"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                /// App Name
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'Consultant',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
                  ),
                ),
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
                SidebarTab(
                  icon: Icons.settings,
                  label: "Settings",
                  isSelected: _selectedIndex == 7,
                  onTap: () => setState(() => _selectedIndex = 7),
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
