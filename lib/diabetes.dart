import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'user_data.dart';

class Diabetes extends StatefulWidget {
  const Diabetes({super.key});

  @override
  State<Diabetes> createState() => _DiabetesState();
}

class _DiabetesState extends State<Diabetes> {
  final _formKey = GlobalKey<FormState>();
  int _age = UserData.age;
  // blood pressure = systolic/diastolic
  int _systolic_blood_pressure = UserData.systolic_blood_pressure;
  int _diastolic_blood_pressure = UserData.diastolic_blood_pressure;
  int _no_of_pregnancy = UserData.no_of_pregnancy;
  bool _gestation_in_previous = UserData.gestation_in_previous == 1;
  int _HDL = UserData.HDL;
  // history of family members with diabetes
  bool _family_history = UserData.family_history == 1;
  bool _unexplained_prenetal_loss = UserData.unexplained_prenetal_loss == 1;
  bool _large_child_or_birth_default = UserData.large_child_or_birth_default == 1;
  // polycystic ovarian syndrome
  bool _PCOS = UserData.PCOS == 1;
  double _hemoglobin = UserData.hemoglobin;
  bool _sedentary_lifestyle = UserData.sedentary_lifestyle == 1;
  bool _prediabetes = UserData.prediabetes == 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Diabetes'),
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
                initialValue: _no_of_pregnancy == 0 ? '' : _no_of_pregnancy.toString(),
                decoration: const InputDecoration(
                  labelText: 'No. of Pregnancy',
                ),
                keyboardType: const TextInputType.numberWithOptions(),
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+')),
                ],
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter number of pregnancy';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid number of pregnancy';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _no_of_pregnancy =
                        int.tryParse(value) == null ? 0 : int.parse(value);
                  });
                },
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                initialValue: _HDL == 0 ? '' : _HDL.toString(),
                decoration: const InputDecoration(
                  labelText: 'High Density Lipoprotein (HDL)',
                ),
                keyboardType: const TextInputType.numberWithOptions(),
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+')),
                ],
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter an HDL value';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid HDL value';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _HDL =
                        int.tryParse(value) == null ? 0 : int.parse(value);
                  });
                },
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                initialValue: _hemoglobin == 0 ? '' : _hemoglobin.toString(),
                decoration: const InputDecoration(
                  labelText: 'Hemoglobin',
                ),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                ],
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a hemoglobin value';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid hemoglobin value';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _hemoglobin = double.tryParse(value) == null
                        ? 0
                        : (double.parse(value) * 1.8 + 32);
                  });
                },
              ),
              const SizedBox(height: 20.0),
              // toggle
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    const Text('Gestation in Previous'),
                    const SizedBox(width: 20),
                    Switch(
                      value: _gestation_in_previous,
                      onChanged: (value) {
                        setState(() {
                          _gestation_in_previous = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    const Text('Family History of Diabetes'),
                    const SizedBox(width: 20),
                    Switch(
                      value: _family_history,
                      onChanged: (value) {
                        setState(() {
                          _family_history = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    const Text('Unexplained Prenatal Loss'),
                    const SizedBox(width: 20),
                    Switch(
                      value: _unexplained_prenetal_loss,
                      onChanged: (value) {
                        setState(() {
                          _unexplained_prenetal_loss = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    const Text('Large Child or Birth Default'),
                    const SizedBox(width: 20),
                    Switch(
                      value: _large_child_or_birth_default,
                      onChanged: (value) {
                        setState(() {
                          _large_child_or_birth_default = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    const Text('Polycystic Ovarian Syndrome (PCOS)'),
                    const SizedBox(width: 20),
                    Switch(
                      value: _PCOS,
                      onChanged: (value) {
                        setState(() {
                          _PCOS = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    const Text('Sedentary Lifestyle'),
                    const SizedBox(width: 20),
                    Switch(
                      value: _sedentary_lifestyle,
                      onChanged: (value) {
                        setState(() {
                          _sedentary_lifestyle = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    const Text('Prediabetes'),
                    const SizedBox(width: 20),
                    Switch(
                      value: _prediabetes,
                      onChanged: (value) {
                        setState(() {
                          _prediabetes = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20.0),
              Container(
                alignment: Alignment.center,
                child: ElevatedButton(
                  child: const Text('Confirm'),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      setState(() {
                        UserData.age = _age;
                        UserData.systolic_blood_pressure =
                            _systolic_blood_pressure;
                        UserData.diastolic_blood_pressure =
                            _diastolic_blood_pressure;
                        UserData.no_of_pregnancy = _no_of_pregnancy;
                        UserData.gestation_in_previous =
                            _gestation_in_previous ? 1 : 0;
                        UserData.HDL = _HDL;
                        UserData.family_history = _family_history ? 1 : 0;
                        UserData.unexplained_prenetal_loss =
                            _unexplained_prenetal_loss ? 1 : 0;
                        UserData.large_child_or_birth_default =
                            _large_child_or_birth_default ? 1 : 0;
                        UserData.PCOS = _PCOS ? 1 : 0;
                        UserData.hemoglobin = _hemoglobin;
                        UserData.sedentary_lifestyle = _sedentary_lifestyle ? 1 : 0;
                        UserData.prediabetes = _prediabetes ? 1 : 0;
                      });

                      var userInputs = {
                        'Age': _age,
                        'No of Pregnancy': _systolic_blood_pressure,
                        'Gestation in previous Pregnancy': _diastolic_blood_pressure,
                        'BMI': UserData.bmi,
                        'HDL': _HDL,
                        'Family History': _family_history,
                        'unexplained prenetal loss': _unexplained_prenetal_loss,
                        'Large Child or Birth Default': _large_child_or_birth_default,
                        'PCOS': _PCOS,
                        'Sys BP': _systolic_blood_pressure,
                        'Dia BP': _diastolic_blood_pressure,
                        'Hemoglobin': _hemoglobin,
                        'Sedentary Lifestyle': _sedentary_lifestyle,
                        'Prediabetes': _prediabetes
                      };
                      var jsonData = jsonEncode(userInputs);
                      // Send a POST request to the Flask server with the user input data
                      var url = 'http://10.164.38.230:8080/gestation';
                      var headers = {'Content-Type': 'application/json'};
                      var response = await http.post(Uri.parse(url),
                          headers: headers, body: jsonData);

                      UserData.dia_gdm = jsonDecode(response.body);
                      print(UserData.dia_gdm);
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
