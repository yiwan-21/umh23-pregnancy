import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  bool _presentation_breech = UserData.presentation_breech;
  bool _presentation_cephalic = UserData.presentation_cephalic;
  bool _presentation_other = UserData.presentation_other;
  bool _placenta_previa = UserData.placenta_previa;
  bool _amniotic_normal = UserData.amniotic_normal;
  bool _hypertension_nil = UserData.hypertension_nil;
  bool _diabetes_nil = UserData.diabetes_nil;

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
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      setState(() {
                        UserData.age = _age;
                        UserData.height = _height;
                        UserData.presentation_breech = _presentation_breech;
                        UserData.presentation_cephalic =
                            _presentation_cephalic;
                        UserData.presentation_other = _presentation_other;
                        UserData.placenta_previa = _placenta_previa;
                        UserData.amniotic_normal = _amniotic_normal;
                        UserData.amniotic_anhydramnios = !_amniotic_normal;
                        UserData.hypertension_nil = _hypertension_nil;
                        UserData.hypertension_pih = !_hypertension_nil;
                        UserData.diabetes_nil = _diabetes_nil;
                        UserData.diabetes_gdm = !_diabetes_nil;
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