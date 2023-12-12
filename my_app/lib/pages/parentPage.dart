import 'package:flutter/material.dart';
import 'package:my_app/pages/parentQuestionnaire.dart';


class ParentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome [Parent Name]'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // Notification logic
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Card(
              color: Colors.grey,
              child: ListTile(
                title: Text('Mandatory Questionnaire'),
                subtitle: Text('Please complete questionnaire beforehand',
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
                onTap: () {
                  // Questionnaire logic
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ParentQuestionnairePage()),
                  );
                },
              ),
            ),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                children: List.generate(6, (index) {
                  return Card(
                    child: Center(
                      child: Text('Task ${index + 1}'),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Items',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Add',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
