import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
// import your model and update function
// import '../models/child_data.dart';
// import '../http_requests/update_child.dart';

class EditChildPage extends StatefulWidget {
  final ChildData childData; // Assuming ChildData is your model class

  const EditChildPage({Key? key, required this.childData}) : super(key: key);

  @override
  _EditChildPageState createState() => _EditChildPageState();
}

class _EditChildPageState extends State<EditChildPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _dateOfBirthController;
  String? _sex;
  String? _country;
  String? _educationLevel;
  DateTime? _dateOfBirth;

  // Initialize form fields with existing data
  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.childData.name);
    _dateOfBirthController = TextEditingController(text: DateFormat('dd-MM-yyyy').format(widget.childData.dob));
    _sex = widget.childData.sex;
    _country = widget.childData.country;
    _educationLevel = widget.childData.educationLevel;
    _dateOfBirth = widget.childData.dob;
  }

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
        _dateOfBirthController.text = DateFormat('dd-MM-yyyy').format(picked);
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _dateOfBirthController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Child'),
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
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              GestureDetector(
                onTap: () => _selectDateOfBirth(context),
                child: AbsorbPointer(
                  child: TextFormField(
                    controller: _dateOfBirthController,
                    decoration: InputDecoration(labelText: 'Date of Birth'),
                    validator: (value) {
                      if (_dateOfBirth == null) {
                        return 'Please enter the date of birth';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              // ... (Other form fields and dropdowns similar to your AddChildPage)
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Collect form data
                    final childData = {
                      'FamilyID': widget.childData.familyId,
                      'Name': _nameController.text,
                      'DOB': _dateOfBirthController.text,
                      'Sex': _sex,
                      'Country': _country,
                      'LevelOfEducation': _educationLevel,
                    };

                    // Send data to the API for update
                    updateChild(childData); // Replace this with your actual update function

                    // Show confirmation dialog or navigate
                    // ...
                  }
                },
                child: Text('Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Placeholder for ChildData model class
class ChildData {
  final int familyId;
  final String name;
  final DateTime dob;
  final String? sex;
  final String? country;
  final String? educationLevel;

  ChildData({
    required this.familyId,
    required this.name,
    required this.dob,
    this.sex,
    this.country,
    this.educationLevel,
  });

  // Add other necessary methods and properties
}

// Placeholder for updateChild function
void updateChild(Map<String, dynamic> childData) {
}
