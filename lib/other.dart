import 'package:flutter/material.dart';
import 'ultrasound.dart';
import 'necessities.dart';

class Other extends StatelessWidget {
  Other({super.key});

  final Map<String, Widget> _pages = {
    "Ultrasound": const Ultrasound(),
    "Necessities": Necessities(),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Other'),
        centerTitle: true,
      ),
      // square grid
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: GridView.count(
          crossAxisCount: 4,
          children: _pages.entries.map((entry) {
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => entry.value),
                );
              },
              child: Card(
                elevation: 3,
                child: Center(
                  child: Text(entry.key),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}