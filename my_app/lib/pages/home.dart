// edit child probably needs to be changed so you can select which child
// child page will need to be made into a loop depending on how many children there are

import 'package:flutter/material.dart';
import 'package:my_app/pages/addChild.dart';
import 'package:my_app/pages/childPage.dart';
import 'package:my_app/pages/editChild.dart';
import 'package:my_app/pages/parentPage.dart';
// Import the relevant pages or functionalities
// import 'add_child_page.dart';
// import 'edit_child_page.dart';
// import 'remove_child_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Family Page',
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.bold
          ),
        ),
        backgroundColor: Colors.blue,
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, // Aligns children vertically with space in between
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigation logic for Parent Profile
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ParentPage()),
                      );
                    },
                    child: Text('Parent Profile'),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigation logic for Child Profile
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ChildPage()),
                      );
                    },
                    child: Text('Child Profile'),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // Add Child logic
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AddChildPage()),
                        );
                      },
                      child: Text('Add Child'),
                    ),
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => EditChildPage()), // need to change
                        // );
                      },
                      child: Text('Edit Child'),
                    ),
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // Remove Child logic
                      },
                      child: Text('Remove Child'),
                    ),
                  ),
                ],
              ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Business',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'School',
          ),
        ],
        selectedItemColor: Colors.amber[800],
        // Add onTap callback if needed
      ),
    );
  }
}