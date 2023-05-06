import 'package:flutter/material.dart';

class Diabetes extends StatefulWidget {
  const Diabetes({super.key});

  @override
  State<Diabetes> createState() => _DiabetesState();
}

class _DiabetesState extends State<Diabetes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Diabetes'),
        centerTitle: true,
      ),
    );
  }
}