import 'package:flutter/material.dart';

class Pets extends StatelessWidget {
  const Pets({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pets'),
        centerTitle: true,
      ),
    );
  }
}