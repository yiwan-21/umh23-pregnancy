import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'user_data.dart';

class ModeDelivery extends StatefulWidget {
  const ModeDelivery({super.key});

  @override
  State<ModeDelivery> createState() => _ModeDeliveryState();
}

class _ModeDeliveryState extends State<ModeDelivery> {
  final _formKey = GlobalKey<FormState>();
  int _age = UserData.age;
  double _height = UserData.height;
  bool _presentation_breech = UserData.presentation_breech == 1;
  bool _presentation_cephalic = UserData.presentation_cephalic == 1;
  bool _presentation_other = UserData.presentation_other == 1;
  bool _placenta_previa = UserData.placenta_previa == 1;
  bool _amniotic_normal = UserData.amniotic_normal == 1;
  bool _hypertension_nil = UserData.hypertension_nil == 1;
  bool _diabetes_nil = UserData.diabetes_nil == 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mode of Delivery'),
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
                    return 'Please enter a height value';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid height value';
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
              DropdownButtonFormField(
                decoration: const InputDecoration(
                  labelText: 'Presentation',
                ),
                items: const [
                  DropdownMenuItem(
                    value: 'Breech',
                    child: Text('Presentation Breech'),
                  ),
                  DropdownMenuItem(
                    value: 'Cephalic',
                    child: Text('Presentation Cephalic'),
                  ),
                  DropdownMenuItem(
                    value: 'Other',
                    child: Text('Presentation Other'),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    _presentation_breech = value == 'Breech';
                    _presentation_cephalic = value == 'Cephalic';
                    _presentation_other = value == 'Other';
                  });
                },
              ),
              const SizedBox(height: 20.0),
              // checkbox
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Checkbox(
                      activeColor: Colors.red,
                      value: _placenta_previa,
                      onChanged: (value) {
                        setState(() {
                          _placenta_previa = value!;
                        });
                      },
                    ),
                    const Text('Placentra Site Previa'),
                  ],
                ),
              ),
              const SizedBox(height: 20.0),
              // toggle
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Amniotic Anhydramnios'),
                    const SizedBox(width: 20),
                    Switch(
                      activeColor: Colors.red,
                      value: _amniotic_normal,
                      onChanged: (value) {
                        setState(() {
                          _amniotic_normal = value;
                        });
                      },
                    ),
                    const SizedBox(width: 20),
                    const Text('Amniotic Normal'),
                  ],
                ),
              ),
              const SizedBox(height: 20.0),
              // toggle
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Hypertension Pih'),
                    const SizedBox(width: 20),
                    Switch(
                      activeColor: Colors.red,
                      value: _hypertension_nil,
                      onChanged: (value) {
                        setState(() {
                          _hypertension_nil = value;
                        });
                      },
                    ),
                    const SizedBox(width: 20),
                    const Text('Hypertension Nil'),
                  ],
                ),
              ),
              const SizedBox(height: 20.0),
              // toggle
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Diabetes Gdm'),
                    const SizedBox(width: 20),
                    Switch(
                      activeColor: Colors.red,
                      value: _diabetes_nil,
                      onChanged: (value) {
                        setState(() {
                          _diabetes_nil = value;
                        });
                      },
                    ),
                    const SizedBox(width: 20),
                    const Text('Diabetes Nil'),
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
                        UserData.height = _height;
                        UserData.presentation_breech =
                            _presentation_breech ? 1 : 0;
                        UserData.presentation_cephalic =
                            _presentation_cephalic ? 1 : 0;
                        UserData.presentation_other =
                            _presentation_other ? 1 : 0;
                        UserData.placenta_previa = _placenta_previa ? 1 : 0;
                        UserData.amniotic_normal = _amniotic_normal ? 1 : 0;
                        UserData.amniotic_anhydramnios =
                            !_amniotic_normal ? 1 : 0;
                        UserData.hypertension_nil = _hypertension_nil ? 1 : 0;
                        UserData.hypertension_pih = !_hypertension_nil ? 1 : 0;
                        UserData.diabetes_nil = _diabetes_nil ? 1 : 0;
                        UserData.diabetes_gdm = !_diabetes_nil ? 1 : 0;
                      });
                      var userInputs = {
                        'mum_age': _age,
                        'mum_height': _height,
                        'presentation_breech': _presentation_breech,
                        'presentation_cephalic': _presentation_cephalic,
                        'presentation_other': _presentation_other,
                        'placenta_site_previa': _placenta_previa,
                        'amniotic_anhydramnios': !_amniotic_normal,
                        'amniotic_normal': !_amniotic_normal,
                        'hypertension_nil': _hypertension_nil,
                        'hypertension_pih': !_hypertension_nil,
                        'diabetes_gdm': !_diabetes_nil,
                        'diabetes_nil': _diabetes_nil
                      };
                      var jsonData = jsonEncode(userInputs);
                      // Send a POST request to the Flask server with the user input data
                      var url = 'http://10.164.38.225:8080/mode';
                      var headers = {'Content-Type': 'application/json'};
                      var response = await http.post(Uri.parse(url),
                          headers: headers, body: jsonData);

                      UserData.mode_delivery = jsonDecode(response.body);

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
