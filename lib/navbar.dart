import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:petratest/screens/home_screen.dart';
import 'screens/cart_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/search_screen.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    Searchpage(), // Placeholder for Search Screen
    CartScreen(),
    const ProfileScreen(), // Placeholder for Profile Screen
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: _widgetOptions.elementAt(_selectedIndex),
          ),
          Positioned(
            left: 20,
            right: 20,
            bottom: 20,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30.0), // Adjust the radius as needed
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9), // Background color with transparency
                  borderRadius: BorderRadius.circular(30.0), // Same radius as ClipRRect
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26, // Shadow color
                      blurRadius: 10.0, // Shadow blur radius
                      offset: Offset(0, 4), // Shadow offset
                    ),
                  ],
                ),
                child: GNav(
                  onTabChange: _onItemTapped,
                  gap: 8,
                  tabBackgroundColor: Colors.grey, // Background color for active tab
                  activeColor: Colors.black,
                  padding: const EdgeInsets.all(15),
                  tabs: const [
                    GButton(
                      icon: Icons.home_outlined,
                      text: 'Inicio',
                    ),
                    GButton(
                      icon: Icons.search_outlined,
                      text: 'Buscar',
                    ),
                    GButton(
                      icon: Icons.shopping_cart_outlined,
                      text: 'Carrito',
                    ),
                    GButton(
                      icon: Icons.person_outline,
                      text: 'Perfil',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
