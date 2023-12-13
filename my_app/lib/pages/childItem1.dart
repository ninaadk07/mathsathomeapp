import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:my_app/pages/childPage.dart';

class ChildrenItem1Page extends StatefulWidget {
  @override
  _ChildrenItem1PageState createState() => _ChildrenItem1PageState();
}

class _ChildrenItem1PageState extends State<ChildrenItem1Page> {
  static const int totalItems = 10;
  int questionCount = 0;
  late int correctCount;
  int selectedCount = 0;
  int points = 0;
  int maxQuestions = 10;
  List<bool> items = List.generate(totalItems, (_) => false);

  @override
  void initState() {
    super.initState();
    correctCount = math.Random().nextInt(totalItems) + 1;
  }

  void endGame() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => ScorePage(points: points),
      ),
    );
  }

  void nextQuestion() {
    if (questionCount < maxQuestions) { // Allow for the 10th question
      if (selectedCount == correctCount) {
        points += 1;
      }

      if (questionCount == maxQuestions - 1) { // Check if it's the last question
        endGame();
      } else {
        setState(() {
          questionCount++;
          items = List.generate(totalItems, (_) => false);
          correctCount = math.Random().nextInt(totalItems) + 1;
          selectedCount = 0;
        });
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Counting Game'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(16),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: totalItems,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      if (selectedCount < correctCount || items[index]) {
                        items[index] = !items[index];
                        selectedCount += items[index] ? 1 : -1;
                      }
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: items[index] ? Colors.green : null,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.yellow, width: 4),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Can you pick $correctCount items?',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          ElevatedButton(
            onPressed: nextQuestion,
            child: Text('Next'),
            style: ElevatedButton.styleFrom(
              minimumSize: Size(double.infinity, 50), // full width button
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
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

class ScorePage extends StatelessWidget {
  final int points;

  const ScorePage({Key? key, required this.points}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Finished'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Your Got $points Questions Correctly', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Replace with navigation to the desired page
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => ChildPage()),
                  ModalRoute.withName('/'),
                );
              },
              child: Text('Continue'),
            ),
          ],
        ),
      ),
    );
  }
}
