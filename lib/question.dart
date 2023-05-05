import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Question extends StatefulWidget {
  const Question({super.key});

  @override
  State<Question> createState() => _QuestionState();
}

class _QuestionState extends State<Question> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  double _amount = 0;
  DateTime _date = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2020),
        lastDate: DateTime(2025));
    if (picked != null) {
      setState(() {
        _date = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Questions'),
      ),
      body: Container(
        padding: const EdgeInsets.all(8.0), 
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Title',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your title';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _title = value;
                  });
                },
              ),
              const SizedBox(height: 20.0),
              // date
              TextFormField(
                readOnly: true,
                onTap: () {
                  _selectDate(context);
                },
                decoration: const InputDecoration(
                  labelText: 'Date',
                  suffixIcon: Icon(Icons.calendar_today),
                ),
                controller: TextEditingController(
                  text: _date.toString().substring(0, 10),
                ),
              ),
              const SizedBox(height: 20.0),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Amount',
                      ),
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(
                            RegExp(r'^\d+\.?\d{0,2}')),
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
                ],
              ),
              const SizedBox(height: 20.0),
              Container(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  child: const Text('Confirm'),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Form is valid, do something
                      _formKey.currentState!.save();
                      // For example, submit the form to a server
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
