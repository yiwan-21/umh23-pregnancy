import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'user_data.dart';

class Question extends StatefulWidget {
  const Question({super.key});

  @override
  State<Question> createState() => _QuestionState();
}

class _QuestionState extends State<Question> {
  final _formKey = GlobalKey<FormState>();

  Future<void> _selectDueDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: UserData.due_date == null ? DateTime.now() : UserData.due_date!,
        firstDate: DateTime(2020),
        lastDate: DateTime(2025));
    if (picked != null) {
      setState(() {
        UserData.due_date = picked;
      });
    }
  }

  Future<void> _selectLastPeriod(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: UserData.last_period == null ? DateTime.now() : UserData.last_period!,
        firstDate: DateTime(2020),
        lastDate: DateTime(2025));
    if (picked != null) {
      setState(() {
        UserData.last_period = picked;
        UserData.due_date = picked.add(const Duration(days: 280));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Personal Data Questionnaire'),
      ),
      body: Container(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                readOnly: true,
                decoration: const InputDecoration(
                  labelText: 'Estimated Due Date',
                ),
                controller: TextEditingController(
                  text: UserData.due_date == null
                      ? "Unset"
                      : UserData.due_date.toString().substring(0, 10),
                ),
              ),
              const SizedBox(height: 10.0),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      child: const Text('Estimated Due Date',),
                      onPressed: () {
                        _selectDueDate(context);
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      child: const Text('Last Period Date',),
                      onPressed: () {
                        _selectLastPeriod(context);
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                initialValue: UserData.height == 0 ? '' : UserData.height.toString(),
                decoration: const InputDecoration(
                  labelText: 'Age',
                ),
                keyboardType:
                    const TextInputType.numberWithOptions(),
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(
                      RegExp(r'^\d+')),
                ],
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter an age';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid age';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    UserData.age = int.tryParse(value) == null
                        ? 0
                        : int.parse(value);
                  });
                },
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                initialValue: UserData.height == 0 ? '' : UserData.height.toString(),
                decoration: const InputDecoration(
                  labelText: 'Height',
                ),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(
                      RegExp(r'^\d+\.?\d{0,2}')),
                ],
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter an height';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid height';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    UserData.height = double.tryParse(value) == null
                        ? 0
                        : double.parse(value);
                  });
                },
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                initialValue: UserData.weight == 0 ? '' : UserData.weight.toString(),
                decoration: const InputDecoration(
                  labelText: 'Weight',
                ),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(
                      RegExp(r'^\d+\.?\d{0,2}')),
                ],
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter an weight';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid weight';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    UserData.weight = double.tryParse(value) == null
                        ? 0
                        : double.parse(value);
                  });
                },
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                initialValue: UserData.systolic_blood_pressure == 0 ? '' : UserData.systolic_blood_pressure.toString(),
                decoration: const InputDecoration(
                  labelText: 'Systolic Blood Pressure (mmHg)',
                  hintText: 'Upper number',
                ),
                keyboardType:
                    const TextInputType.numberWithOptions(),
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(
                      RegExp(r'^\d+')),
                ],
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a systolic blood pressure';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid systolic blood pressure';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    UserData.systolic_blood_pressure = int.tryParse(value) == null
                        ? 0
                        : int.parse(value);
                  });
                },
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                initialValue: UserData.diastolic_blood_pressure == 0 ? '' : UserData.diastolic_blood_pressure.toString(),
                decoration: const InputDecoration(
                  labelText: 'Diastolic Blood Pressure (mmHg)',
                  hintText: 'Lower number',
                ),
                keyboardType:
                    const TextInputType.numberWithOptions(),
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(
                      RegExp(r'^\d+')),
                ],
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a diastolic blood pressure';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid diastolic blood pressure';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    UserData.diastolic_blood_pressure = int.tryParse(value) == null
                        ? 0
                        : int.parse(value);
                  });
                },
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                initialValue: UserData.sugar_level == 0 ? '' : UserData.sugar_level.toString(),
                decoration: const InputDecoration(
                  labelText: 'Sugar Level (mg/DL)',
                ),
                keyboardType:
                    const TextInputType.numberWithOptions(),
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(
                      RegExp(r'^\d+')),
                ],
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter an sugar level';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid sugar level';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    UserData.sugar_level = int.tryParse(value) == null
                        ? 0
                        : int.parse(value);
                  });
                },
              ),
              const SizedBox(height: 20.0),
              // radio button input
              const Text(
                'Stress Level',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              RadioListTile<int>(
                title: const Text('Low'),
                value: 1,
                groupValue: UserData.stress_level,
                visualDensity: const VisualDensity(
                  horizontal: VisualDensity.minimumDensity,
                  vertical: VisualDensity.minimumDensity,
                ),
                onChanged: (int? value) {
                  setState(() {
                    UserData.stress_level = value!;
                  });
                },
              ),
              RadioListTile<int>(
                title: const Text('Medium'),
                value: 2,
                groupValue: UserData.stress_level,
                visualDensity: const VisualDensity(
                  horizontal: VisualDensity.minimumDensity,
                  vertical: VisualDensity.minimumDensity,
                ),
                onChanged: (int? value) {
                  setState(() {
                    UserData.stress_level = value!;
                  });
                },
              ),
              RadioListTile<int>(
                title: const Text('High'),
                value: 3,
                groupValue: UserData.stress_level,
                visualDensity: const VisualDensity(
                  horizontal: VisualDensity.minimumDensity,
                  vertical: VisualDensity.minimumDensity,
                ),
                onChanged: (int? value) {
                  setState(() {
                    UserData.stress_level = value!;
                  });
                },
              ),
              const SizedBox(height: 20.0),
              Container(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  child: const Text('Confirm'),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      setState(() {
                        UserData.last_filled = DateTime.now();
                      });
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
