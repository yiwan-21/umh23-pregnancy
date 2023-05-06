import 'package:flutter/material.dart';
import 'ultrasound.dart';
import 'health_risk.dart';
import 'diabetes.dart';
import 'fetus_size.dart';
import 'mode_delivery.dart';
import 'necessities.dart';
import 'pets.dart';

class Other extends StatelessWidget {
  Other({super.key});

  final Map<String, Widget> _pages = {
    "Ultrasound": const Ultrasound(),
    "Health Risk": const HealthRisk(),
    "Diabetes": const Diabetes(),
    "Fetus Size": FetusSize(),
    "Mode of Delivery": const ModeDelivery(),
    "Necessities": Necessities(),
    "Pets": const Pets(),
  };

  final List<String> _images = [
    'assets/images/ultrasound.png',
    'assets/images/health risk.png',
    'assets/images/diabetes.png',
    'assets/images/fetus size.png',
    'assets/images/mode of delivery.png',
    'assets/images/necessities.png',
    'assets/images/pets.png',
  ];

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
          crossAxisCount:
              MediaQuery.of(context).orientation == Orientation.portrait
                  ? 3
                  : 6,
          children: _pages.entries.map((entry) {
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => entry.value),
                );
              },
              child: Column(
                children: [
                  Card(
                    elevation: 3,
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Image.asset(
                        _images[_pages.keys.toList().indexOf(entry.key)],
                        height: 80,
                        width: 80,
                      ),
                    ),
                  ),
                  Text(
                    entry.key,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
