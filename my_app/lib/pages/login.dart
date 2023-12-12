import 'package:flutter/material.dart';
import 'package:my_app/pages/home.dart';
// import 'package:my_app/pages/register.dart'; // Import your registration page

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isUser = true; // Toggle state

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch, // Aligns children horizontally
          children: <Widget>[
            Center( // Center the ToggleButtons
              child: ToggleButtons(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text('User'),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text('Researcher'),
                  ),
                ],
                isSelected: [_isUser, !_isUser],
                onPressed: (int index) {
                  setState(() {
                    _isUser = index == 0;
                  });
                },
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
                // Add login logic based on _isUser
              },
              child: Text('Login as ${_isUser ? 'User' : 'Researcher'}'),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Don't have an account? "),
                TextButton(
                  onPressed: () {
                    // Navigate to registration page
                    // Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterPage()));
                  },
                  child: Text('Register'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
