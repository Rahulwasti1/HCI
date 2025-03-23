import 'package:flutter/material.dart';
import 'package:hci/constants/colors.dart';
import 'package:hci/screens/main/home_screen.dart';
import 'package:hci/screens/main/chat_screen.dart';
import 'package:hci/screens/main/profile_screen.dart';
import 'package:hci/screens/main/monitor_screen.dart';
import 'package:hci/screens/scan_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const MonitorScreen(),
    const ChatScreen(),
    const ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Open the scan screen
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const ScanScreen()),
          );
        },
        backgroundColor: AppColors.primary,
        elevation: 4,
        mini:
            false, // Ensure this is set to false (to keep the default large size)
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30), // Circular border radius
        ),
        child: SizedBox(
          height: 25, // Increase the height of the FAB
          width: 25, // Increase the width of the FAB
          child: Image.asset(
            'assets/images/scan.png',
            height: 20, // Image size (inside the button)
            width: 20, // Image size (inside the button)
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        height: 50, // Ensure fixed height
        padding: EdgeInsets.zero, // Remove default padding
        shape: const CircularNotchedRectangle(),
        color: const Color.fromARGB(77, 217, 215, 215),
        notchMargin: 6,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(0, Icons.home_outlined, Icons.home, 'Home'),
            _buildNavItem(1, Icons.bolt_outlined, Icons.bolt, 'Monitor'),
            // Empty space for FAB
            const SizedBox(width: 40),
            _buildNavItem(
                2, Icons.chat_bubble_outline, Icons.chat_bubble, 'Chat'),
            _buildNavItem(3, Icons.person_outline, Icons.person, 'Profile'),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(
      int index, IconData icon, IconData activeIcon, String label) {
    final isSelected = _selectedIndex == index;
    return Expanded(
      child: InkWell(
        onTap: () => _onItemTapped(index),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 2),
              child: Icon(
                isSelected ? activeIcon : icon,
                color: isSelected ? AppColors.primary : AppColors.textLight,
                size: 22,
              ),
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                color: isSelected ? AppColors.primary : AppColors.textLight,
                fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
