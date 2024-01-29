import 'package:flutter/material.dart';
import 'package:my_app/pages/child_items/compareNumberToItem.dart';
import 'package:my_app/pages/child_items/compareNumbers.dart';
import 'package:my_app/pages/child_items/countingItem.dart';
import 'package:my_app/pages/child_items/compareItem.dart';
import 'package:my_app/pages/child_items/numberSequence.dart';
import 'package:my_app/pages/child_items/oneDigitAddition.dart';
import 'package:my_app/pages/child_items/oneDigitSubstraction.dart';
import 'package:my_app/pages/home.dart';

// Change the cases and its corresponding pages
// make the child items all into a list and make it based on their ids
class ChildPage extends StatelessWidget {
    void _navigateToTask(BuildContext context, int taskIndex) {
    Widget taskPage;

    switch (taskIndex) {
      case 0:
        taskPage = CountingItemsPage();
        break;
      case 1:
        taskPage = CompareItemsPage();
        break;
      case 2:
        taskPage = CompareNumbersPage();
        break;
      case 3:
        taskPage = CompareNumberToItemPage();
      case 4:
        taskPage = NumberSequencePage();
      case 5:
        taskPage = OneDigitAdditionPage();
      case 6:
        taskPage = OneDigitSubtractionPage();
      // Add more cases for each task
      default:
        taskPage = HomePage();
    }

    Navigator.push(context, MaterialPageRoute(builder: (context) => taskPage));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome [Child Name]'),
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
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                children: List.generate(8, (index) {
                  return GestureDetector(
                    onTap: () => _navigateToTask(context, index), // change the index into the task id
                    child: Card(
                      child: Center(
                        child: Text('Task ${index + 1}'),
                      ),
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
