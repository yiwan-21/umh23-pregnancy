import 'package:flutter/material.dart';
import './home.dart';
import './question.dart';
import './ultrasound.dart';

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
    switch (index) {
      case 0:
        break;
      default:
    }
  }

  final Map<String, Widget> _pages = {
    "Home": const Home(),
    "Tracker": const Question(),
    "Ultrasound": const Ultrasound(),
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
            icon: Icon(Icons.question_answer_outlined),
            label: 'Question',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera_alt_outlined),
            label: 'Ultrasound',
          ),
        ],
        onTap: _onItemTapped,
      ),
    );
  }
}
