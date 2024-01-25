import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';

final FlutterSecureStorage secureStorage = FlutterSecureStorage();

Future<void> addChild(Map<String, dynamic> childData) async {
  final familyID = childData['FamilyID'];

  DateTime parsedDate = DateFormat('dd-MM-yyyy').parse(childData['DOB']);
  String formattedDate = DateFormat('yyyy-MM-dd').format(parsedDate);
  childData['DOB'] = formattedDate;
  if (familyID == null) {
    print("Family ID is null. Cannot proceed.");
    return;
  }

  final url = Uri.parse('http://127.0.0.1:5000/database/child');
  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json',
      'FamilyID': familyID, // Include FamilyID in the header
    },
    body: json.encode(childData),
  );

  if (response.statusCode == 201) {
    print('Child added to the database');
  } else {
    print('Failed to add child. Status code: ${response.statusCode}');
  }
}

Future<bool> registerUser(Map<String, dynamic> userData) async {
  final url = Uri.parse('http://127.0.0.1:5000/database/register');
  final response = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: json.encode(userData),
  );

  if (response.statusCode == 201) {
    final responseJson = json.decode(response.body);
    final token = responseJson['token'];
    secureStorage.write(key: 'authToken', value: token);
    return true;
  } else {
    print('Failed to register user. Status code: ${response.statusCode}');
    return false;
  }
}

Future<String> login(String email, String password) async {
  final url = Uri.parse('http://127.0.0.1:5000/login'); 
  try {
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      final familyID = responseJson['familyID'].toString();
      await secureStorage.write(key: 'familyID', value: familyID);
      return 'Login successful';
    } else {
      return 'Login failed';
    }
  } catch (e) {
    return 'Error: ${e.toString()}';
  }
}