import 'package:flutter/material.dart';
import 'home.dart';
import 'question.dart';
import 'community.dart';
import 'nutrition.dart';
import 'other.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final Map<String, Widget> _pages = {
    "Home": const Home(),
    "Personal": const Question(),
    "Community": const Community(),
    "Nutrition": const Nutrition(),
    "Other": Other(),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages.values.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: true,
        selectedItemColor: Colors.pink,
        unselectedItemColor: Colors.black,
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.article_outlined),
            label: 'Personal',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_alt_outlined),
            label: 'Community',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_dining_outlined),
            label: 'Nutrition',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.more_horiz_outlined),
            label: 'Other',
          ),
        ],
        onTap: _onItemTapped,
      ),
    );
  }
}
