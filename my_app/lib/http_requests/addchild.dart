import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> addChild(Map<String, dynamic> childData) async {
  final url = Uri.parse('http://127.0.0.1:5000/database/child'); // Replace with your actual API endpoint
  final response = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: json.encode(childData),
  );

  if (response.statusCode == 201) {
    // Success
    print('Child added to the database');
  } else {
    // Error
    print('Failed to add child. Status code: ${response.statusCode}');
  }
}
