import 'package:amulx/MainScreenPages/categories_page.dart';
import 'package:amulx/MainScreenPages/profile_page.dart';
import 'package:flutter/material.dart';

import 'MainScreenPages/cart_page.dart';
import 'MainScreenPages/home_page.dart';

class NavBarPage extends StatefulWidget {
  const NavBarPage({super.key});

  @override
  State<NavBarPage> createState() => _NavBarPageState();
}

class _NavBarPageState extends State<NavBarPage> {

  int _selectedIndex = 0;

  void navigateBar(int index){
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = [
    HomePage(),
    CategoriesPage(),
    CartPage(),
    ProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.lightBlueAccent,
        selectedItemColor: Color(0xff191970),
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: false,
          iconSize: 25,
          selectedLabelStyle: TextStyle(letterSpacing: 3,fontWeight: FontWeight.bold),
          currentIndex: _selectedIndex,
          onTap: navigateBar,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home,),label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.apps_rounded),label: 'Categories'),
            BottomNavigationBarItem(icon: Icon(Icons.shopping_cart,),label: 'Cart'),
            BottomNavigationBarItem(icon: Icon(Icons.person,),label: 'Account'),
          ]),
    );
  }
}
