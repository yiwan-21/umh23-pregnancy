import 'package:flutter/material.dart';

import 'user_data.dart';

class FetusSize extends StatelessWidget {
  FetusSize({super.key});
  final Map<String, String> fruits = {
    'Poppy Seed': 'assets/images/fruit/poppyseed.jpeg',
    'Apple Seed': 'assets/images/fruit/appleseed.jpeg',
    'Sweet Pea': 'assets/images/fruit/sweetpea.jpeg',
    'Blueberry': 'assets/images/fruit/blueberry.jpeg',
    'Raspberry': 'assets/images/fruit/raspberry.jpeg',
    'Lime': 'assets/images/fruit/lime.jpeg',
    'Peach': 'assets/images/fruit/peach.jpeg',
    'Avocado': 'assets/images/fruit/avocado.jpeg',
    'Onion': 'assets/images/fruit/onion.jpeg',
    'Mango': 'assets/images/fruit/mango.jpeg',
    'Papaya': 'assets/images/fruit/papaya.jpeg',
    'Grapefruit': 'assets/images/fruit/grapefruit.jpeg',
    'Cauliflower': 'assets/images/fruit/cauliflower.jpeg',
    'Cucumber': 'assets/images/fruit/cucumber.jpeg',
    'Butternut Squash': 'assets/images/fruit/butternutsquash.jpeg',
    'Pineapple': 'assets/images/fruit/pineapple.jpeg',
    'Cantaloupe': 'assets/images/fruit/cantaloupe.jpeg',
    'Honey Melon': 'assets/images/fruit/honeymelon.jpeg',
    'Watermelon': 'assets/images/fruit/watermelon.jpeg',
    'Pumpkin': 'assets/images/fruit/pumpkin.jpeg',
  };

  int getFruitIndex(int weeks) {
    int index = (weeks - 1) ~/ 2;
    if (index < 0) index = 0;
    if (index > 20) index = 20;
    return index;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fetus Size'),
        centerTitle: true,
      ),
      body: UserData.last_filled == null
          ? Container(
              margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: const Text(
                "Please fill in complete your Personal Questionnaire to get started",
                textAlign: TextAlign.center,
              ),
            )
          : ListView(
              children: [
                const SizedBox(height: 20.0),
                Text(
                  "Week ${UserData.weeks} / Days ${UserData.days}",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20.0),
                Center(
                  child: CircleAvatar(
                    radius: 100,
                    backgroundImage: AssetImage(
                      fruits.values.elementAt(getFruitIndex(UserData.weeks)),
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                Text(
                  "Your baby is as big as a ${fruits.keys.elementAt(getFruitIndex(UserData.weeks))}!",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
    );
  }
}
