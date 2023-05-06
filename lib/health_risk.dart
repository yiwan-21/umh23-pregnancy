import 'package:flutter/material.dart';

class HealthRisk extends StatefulWidget {
  const HealthRisk({super.key});

  @override
  State<HealthRisk> createState() => _HealthRiskState();
}

class _HealthRiskState extends State<HealthRisk> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Health Risk'),
        centerTitle: true,
      ),
    );
  }
}