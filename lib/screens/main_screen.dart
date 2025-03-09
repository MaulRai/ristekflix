import 'package:flutter/material.dart';
import 'package:ristekflix/screens/home_screen.dart';
import 'package:ristekflix/screens/profile_screen.dart';
import 'package:ristekflix/screens/search_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    SearchScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _selectedIndex == 0 ? Color(0xFF5038BC) : Colors.white,
      body: _screens[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors
              .deepPurple.shade900, // Ensure this is the navbar background
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 3,
              blurRadius: 10,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            backgroundColor: Colors.white,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Color(0xFF5038BC),
            unselectedItemColor: Colors.grey.shade400,
            showUnselectedLabels: true,
            elevation: 0,
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home_filled,
                  size: 28,
                  color: Color(0xFF5038BC),
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.search_rounded,
                  size: 28,
                  color: Color(0xFF5038BC),
                ),
                label: 'Search',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.person_rounded,
                  size: 28,
                  color: Color(0xFF5038BC),
                ),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
