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
  DateTime? _due_date = UserData.due_date;
  DateTime? _last_period = UserData.last_period;
  int _age = UserData.age;
  double _weight = UserData.weight;
  double _height = UserData.height;
  // blood pressure = systolic/diastolic
  int _systolic_blood_pressure = UserData.systolic_blood_pressure;
  int _diastolic_blood_pressure = UserData.diastolic_blood_pressure;
  int _sugar_level = UserData.sugar_level; // mg/DL
  int _stress_level = UserData.stress_level;

  Future<void> _selectDueDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _due_date == null ? DateTime.now() : _due_date!,
        firstDate: DateTime(2020),
        lastDate: DateTime(2025));
    if (picked != null) {
      setState(() {
        _due_date = picked;
      });
    }
  }

  Future<void> _selectLastPeriod(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _last_period == null ? DateTime.now() : _last_period!,
        firstDate: DateTime(2020),
        lastDate: DateTime(2025));
    if (picked != null) {
      setState(() {
        _last_period = picked;
        _due_date = picked.add(const Duration(days: 280));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Personal Data Questionnaire'),
        centerTitle: true,
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
                  text: _due_date == null
                      ? "Unset"
                      : _due_date.toString().substring(0, 10),
                ),
              ),
              const SizedBox(height: 10.0),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      child: const Text(
                        'Estimated Due Date',
                      ),
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
                      child: const Text(
                        'Last Period Date',
                      ),
                      onPressed: () {
                        _selectLastPeriod(context);
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                initialValue: _age == 0 ? '' : _age.toString(),
                decoration: const InputDecoration(
                  labelText: 'Age',
                ),
                keyboardType: const TextInputType.numberWithOptions(),
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+')),
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
                    _age = int.tryParse(value) == null ? 0 : int.parse(value);
                  });
                },
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                initialValue: _height == 0 ? '' : _height.toString(),
                decoration: const InputDecoration(
                  labelText: 'Height (cm)',
                ),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
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
                    _height = double.tryParse(value) == null
                        ? 0
                        : double.parse(value);
                  });
                },
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                initialValue: _weight == 0 ? '' : _weight.toString(),
                decoration: const InputDecoration(
                  labelText: 'Weight (kg)',
                ),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
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
                    _weight = double.tryParse(value) == null
                        ? 0
                        : double.parse(value);
                  });
                },
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                initialValue: _systolic_blood_pressure == 0
                    ? ''
                    : _systolic_blood_pressure.toString(),
                decoration: const InputDecoration(
                  labelText: 'Systolic Blood Pressure (mmHg)',
                  hintText: 'Upper number',
                ),
                keyboardType: const TextInputType.numberWithOptions(),
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+')),
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
                    _systolic_blood_pressure =
                        int.tryParse(value) == null ? 0 : int.parse(value);
                  });
                },
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                initialValue: _diastolic_blood_pressure == 0
                    ? ''
                    : _diastolic_blood_pressure.toString(),
                decoration: const InputDecoration(
                  labelText: 'Diastolic Blood Pressure (mmHg)',
                  hintText: 'Lower number',
                ),
                keyboardType: const TextInputType.numberWithOptions(),
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+')),
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
                    _diastolic_blood_pressure =
                        int.tryParse(value) == null ? 0 : int.parse(value);
                  });
                },
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                initialValue: _sugar_level == 0 ? '' : _sugar_level.toString(),
                decoration: const InputDecoration(
                  labelText: 'Sugar Level (mg/DL)',
                ),
                keyboardType: const TextInputType.numberWithOptions(),
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+')),
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
                    _sugar_level =
                        int.tryParse(value) == null ? 0 : int.parse(value);
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
                activeColor: Colors.red,
                value: 1,
                groupValue: _stress_level,
                visualDensity: const VisualDensity(
                  horizontal: VisualDensity.minimumDensity,
                  vertical: VisualDensity.minimumDensity,
                ),
                onChanged: (int? value) {
                  setState(() {
                    _stress_level = value!;
                  });
                },
              ),
              RadioListTile<int>(
                title: const Text('Medium'),
                activeColor: Colors.red,
                value: 2,
                groupValue: _stress_level,
                visualDensity: const VisualDensity(
                  horizontal: VisualDensity.minimumDensity,
                  vertical: VisualDensity.minimumDensity,
                ),
                onChanged: (int? value) {
                  setState(() {
                    _stress_level = value!;
                  });
                },
              ),
              RadioListTile<int>(
                title: const Text('High'),
                activeColor: Colors.red,
                value: 3,
                groupValue: _stress_level,
                visualDensity: const VisualDensity(
                  horizontal: VisualDensity.minimumDensity,
                  vertical: VisualDensity.minimumDensity,
                ),
                onChanged: (int? value) {
                  setState(() {
                    _stress_level = value!;
                  });
                },
              ),
              const SizedBox(height: 20.0),
              Container(
                alignment: Alignment.center,
                child: ElevatedButton(
                  child: const Text('Confirm'),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      setState(() {
                        UserData.due_date = _due_date;
                        UserData.last_period = _last_period;
                        UserData.weeks =
                            _due_date!.difference(DateTime.now()).inDays ~/ 7;
                        UserData.days =
                            _due_date!.difference(DateTime.now()).inDays;
                        UserData.age = _age;
                        UserData.weight = _weight;
                        UserData.height = _height;
                        UserData.bmi =
                            _weight / ((_height / 100) * (_height / 100));
                        UserData.systolic_blood_pressure =
                            _systolic_blood_pressure;
                        UserData.diastolic_blood_pressure =
                            _diastolic_blood_pressure;
                        UserData.sugar_level = _sugar_level;
                        UserData.stress_level = _stress_level;

                        UserData.last_filled = DateTime.now();
                      });
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            // ask to navigate or not
                            return AlertDialog(
                              title: const Text("Your data has been saved!"),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text(
                                    "Ok",
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ),
                              ],
                            );
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
