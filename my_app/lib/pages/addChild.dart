import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../http_requests/addchild.dart';


class AddChildPage extends StatefulWidget {
  @override
  _AddChildPageState createState() => _AddChildPageState();
}

class _AddChildPageState extends State<AddChildPage> {
  final _formKey = GlobalKey<FormState>();
  final _ageController = TextEditingController();
  final _nameController = TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();
  String? _sex;
  String? _country;
  String? _educationLevel;
  List<String> _sexOptions = ['Male', 'Female', 'Other'];
  List<String> _countries = ['United States', 'Canada', 'United Kingdom', 'Australia', 'Other']; // Add more countries as needed
  List<String> _educationLevels = ["Pre-School", "Primary School", "Middle School", "High School", "Home School"]; // Add more education levels as needed
  DateTime? _dateOfBirth;

  // Function to show Date Picker
  Future<void> _selectDateOfBirth(BuildContext context) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: _dateOfBirth ?? DateTime.now(),
    firstDate: DateTime(1900),
    lastDate: DateTime.now(),
  );
  if (picked != null && picked != _dateOfBirth) {
    setState(() {
      _dateOfBirth = picked;
      // Update the text in the controller with the formatted date
      _dateOfBirthController.text = DateFormat('dd-MM-yyyy').format(picked);
    });
  }
}

  @override
  void dispose() {
    _ageController.dispose();
    _nameController.dispose();
    _dateOfBirthController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Child'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              GestureDetector(
                onTap: () => _selectDateOfBirth(context),
                child: AbsorbPointer(
                  child: TextFormField(
                    controller: _dateOfBirthController,
                    decoration: InputDecoration(
                      labelText: 'Date of Birth',
                    ),
                    validator: (value) {
                      if (_dateOfBirth == null) {
                        return 'Please enter your date of birth';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              DropdownButtonFormField<String>(
                value: _sex,
                decoration: InputDecoration(labelText: 'Sex'),
                items: _sexOptions.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _sex = newValue!;
                  });
                },
                validator: (value) => value == null ? 'Please select your sex' : null,
              ),
              DropdownButtonFormField<String>(
                value: _country,
                decoration: InputDecoration(labelText: 'Country of Residence'),
                items: _countries.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _country = newValue!;
                  });
                },
                validator: (value) => value == null ? 'Please select your country' : null,
              ),
              DropdownButtonFormField<String>(
                value: _educationLevel,
                decoration: InputDecoration(labelText: 'Level of Education'),
                items: _educationLevels.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _educationLevel = newValue!;
                  });
                },
                validator: (value) => value == null ? 'Please select your education level' : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Collect form data
                    final childData = {
                      'FamilyID': 1, // this is hardcoded now for test purposes, but goal is to choose the family ID of the parent that's signing up the child
                      'Name': _nameController.text,
                      'DOB': _dateOfBirthController.text,
                      'Sex': _sex,
                      'Country': _country,
                      'LevelOfEducation': _educationLevel,
                    };

                    // Send data to the API
                    addChild(childData);

                    // Show confirmation dialog
                    // ...
                  }
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}