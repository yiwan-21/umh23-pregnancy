import 'package:flutter/material.dart';

import 'custom_color.dart';
import 'navigation.dart';
import 'timeline.dart';
import 'care_plan.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: lightPink,
      ),
      routes: {
        '/': (context) => const Navigation(),
        '/timeline': (context) => const TimeLine(),
        '/careplan': (context) => CarePlan(),
      },
    );
  }
}
