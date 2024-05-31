import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'screens/cart_screen.dart';
import 'screens/auth/test_home_screen.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _selectedIndex = 0;
  static List<Widget> _widgetOptions = <Widget>[
    const HomePage(),
    const Text('Search Screen Placeholder'), // Placeholder for Search Screen
    CartScreen(),
    const Text('Profile Screen Placeholder'), // Placeholder for Profile Screen
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GNav(
          onTabChange: _onItemTapped,
          gap: 8,
          tabBackgroundColor: Colors.grey,
          activeColor: Colors.black,
          padding: const EdgeInsets.all(15),
          tabs: const [
            GButton(
              icon: Icons.home_outlined,
              text: 'Home',
            ),
            GButton(
              icon: Icons.search_outlined,
              text: 'Search',
            ),
            GButton(
              icon: Icons.shopping_cart_outlined,
              text: 'Cart',
            ),
            GButton(
              icon: Icons.person_outline,
              text: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
