import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dropdown_search/dropdown_search.dart';

import 'food_list.dart';

class Nutrition extends StatefulWidget {
  const Nutrition({super.key});

  @override
  State<Nutrition> createState() => _NutritionState();
}

class _NutritionState extends State<Nutrition> {
  final _formKey = GlobalKey<FormState>();
  // food: amount
  Map<String, double> _foodIntake = {};
  String _food = '';
  double _amount = 0;

  Map<String, double> _handleSubmit() {
    final Map<String, double> nutrition = {};
    nutrition['Calories'] = 130;
    nutrition['Carbohydrates'] = 28;
    nutrition['Protein'] = 2.7;
    nutrition['Fat'] = 0.3;
    nutrition['Fiber'] = 0.4;
    nutrition['Sodium'] = 0.5;

    _foodIntake.forEach((food, amount) {
      nutrition.updateAll((key, value) => value * amount * 0.01);
    });
    return nutrition;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nutrition'),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: const Text(
                'Check the nutrient intake amount.',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.justify,
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 30),
              child: DropdownSearch<String>(
                items: FoodList.foods,
                popupProps: const PopupProps.dialog(
                  showSelectedItems: true,
                  showSearchBox: true,
                ),
                dropdownDecoratorProps: const DropDownDecoratorProps(
                    dropdownSearchDecoration: InputDecoration(
                  labelText: 'Food',
                )),
                validator: (value) {
                  if (value == null) {
                    return 'Please select a food';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _food = value!;
                  });
                },
              ),
            ),
            const SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 30),
              child: TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Amount (g)',
                ),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                ],
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter an amount';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid amount';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _amount = double.tryParse(value) == null
                        ? 0
                        : double.parse(value);
                  });
                },
              ),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      setState(() {
                        _foodIntake[_food] = _amount;
                      });
                    }
                  },
                  child: const Text('Add'),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_foodIntake.isNotEmpty) {
                      _formKey.currentState!.save();
                      final Map<String, double> nutrition = _handleSubmit();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NutritionDetail(
                            food: _food,
                            nutrition: nutrition,
                          ),
                        ),
                      );
                    }
                    else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please add at least a food'),
                        ),
                      );
                    }
                  },
                  child: const Text('Submit'),
                ),
                const SizedBox(width: 30),
              ],
            ),
            ..._foodIntake.entries.map((entry) {
              return Container(
                margin: const EdgeInsets.only(left: 30, right: 30, top: 15),
                padding: const EdgeInsets.only(left: 20, right: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.greenAccent[100],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(entry.key),
                    Row(
                      children: [
                        Text('${entry.value.toStringAsFixed(2)} g'),
                        IconButton(
                          iconSize: 24,
                          onPressed: () {
                            setState(() {
                              _foodIntake.remove(entry.key);
                            });
                          },
                          icon: const Icon(
                            Icons.close,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            })
          ],
        ),
      ),
    );
  }
}

class NutritionDetail extends StatelessWidget {
  final String food;
  final Map<String, double> nutrition;

  NutritionDetail({required this.food, required this.nutrition, super.key});

  final Map<String, String> _rdi = {
    'Carbohydrates': '175 g',
    'Protein': '71 g',
    'Fiber': '28 g',
    'Calcium': '1000 mg',
    'Vitamin C': '85 mg',
    'Vitamin E': '15 mg',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nutrition'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Card(
            elevation: 3,
            color: Colors.amber[50],
            margin: const EdgeInsets.only(left: 30, right: 30, top: 20),
            child: Container(
              alignment: Alignment.topCenter,
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Nutrient information for $food",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ...nutrition.entries.map((entry) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(entry.key, style: const TextStyle(fontSize: 15)),
                        Text('${entry.value.toStringAsFixed(2)} g',
                            style: const TextStyle(fontSize: 15)),
                      ],
                    );
                  }).toList(),
                ],
              ),
            ),
          ),
          Card(
            elevation: 3,
            color: Colors.amber[50],
            margin: const EdgeInsets.only(left: 30, right: 30, top: 20),
            child: Container(
              alignment: Alignment.topCenter,
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    "Recommended Daily Intake (RDI)",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ..._rdi.entries.map((entry) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(entry.key, style: const TextStyle(fontSize: 15)),
                        Text(entry.value, style: const TextStyle(fontSize: 15)),
                      ],
                    );
                  })
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
