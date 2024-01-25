import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final FlutterSecureStorage secureStorage = FlutterSecureStorage();

Future<void> addChild(Map<String, dynamic> childData) async {
  // Ensure that we await the completion of any Future before using its result.
  final familyID = await secureStorage.read(key: 'FamilyID');

  // Make sure familyID is not null before proceeding
  if (familyID == null) {
    print("Family ID is null. Cannot proceed.");
    return;
  }

  // Add familyID to childData
  childData['FamilyID'] = familyID;

  final url = Uri.parse('http://127.0.0.1:5000/database/child');
  final response = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: json.encode(childData), // childData should be a Map that can be encoded to JSON
  );

  // Handle the response
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
      return 'Login successful';
    } else {
      return 'Login failed';
    }
  } catch (e) {
    return 'Error: ${e.toString()}';
  }
}