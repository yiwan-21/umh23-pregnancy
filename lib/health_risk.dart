import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'user_data.dart';

class HealthRisk extends StatefulWidget {
  const HealthRisk({super.key});

  @override
  State<HealthRisk> createState() => _HealthRiskState();
}

class _HealthRiskState extends State<HealthRisk> {
  final _formKey = GlobalKey<FormState>();
  int _age = UserData.age;
  // blood pressure = systolic/diastolic
  int _systolic_blood_pressure = UserData.systolic_blood_pressure;
  int _diastolic_blood_pressure = UserData.diastolic_blood_pressure;
  int _sugar_level = UserData.sugar_level;
  double _temperature = UserData.temperature; // °F
  int _heart_rate = UserData.heart_rate;
  int _stress_level = UserData.stress_level;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Health Risk'),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
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
              TextFormField(
                initialValue: _temperature == 0
                    ? ''
                    : ((_temperature - 32) / 1.8).toString(),
                decoration: const InputDecoration(
                  labelText: 'Temperature (°C)',
                ),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                ],
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a temperature';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid temperature';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _temperature = double.tryParse(value) == null
                        ? 0
                        : (double.parse(value) * 1.8 + 32);
                  });
                },
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                initialValue: _heart_rate == 0 ? '' : _heart_rate.toString(),
                decoration: const InputDecoration(
                  labelText: 'Heart rate',
                ),
                keyboardType: const TextInputType.numberWithOptions(),
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+')),
                ],
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a heart rate';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid heart rate';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _heart_rate =
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
                        UserData.age = _age;
                        UserData.systolic_blood_pressure =
                            _systolic_blood_pressure;
                        UserData.diastolic_blood_pressure =
                            _diastolic_blood_pressure;
                        UserData.sugar_level = _sugar_level;
                        UserData.temperature = _temperature;
                        UserData.heart_rate = _heart_rate;
                      });
                      showDialog(
                          context: context,
                          builder: ((context) {
                            return AlertDialog(
                              title: const Text("Your data has been saved!"),
                              content: const Text(
                                  "Do you want to have a look on your personalized care plan?"),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text(
                                    "No",
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    Navigator.pushNamed(context, '/careplan');
                                  },
                                  child: const Text(
                                    "Yes",
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ),
                              ],
                            );
                          }));
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
