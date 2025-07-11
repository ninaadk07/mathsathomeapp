import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:my_app/pages/childPage.dart';

class CompareItemsPage extends StatefulWidget {
  @override
  _CompareItemsPageState createState() => _CompareItemsPageState();
}

class _CompareItemsPageState extends State<CompareItemsPage> {
  late int leftItemCount;
  late int rightItemCount;
  int questionCount = 0;
  int points = 0;
  int maxQuestions = 10;

  @override
  void initState() {
    super.initState();
    randomizeItemCount();
  }

  void randomizeItemCount() {
    leftItemCount = math.Random().nextInt(6) + 1; // Random number between 1 and 6
    rightItemCount = math.Random().nextInt(6) + 1;
    while (rightItemCount == leftItemCount) {
      // Ensure the number of items is different on each side
      rightItemCount = math.Random().nextInt(6) + 1;
    }
  }

  void verifyAnswer(bool pickedLeft) {
    if ((pickedLeft && leftItemCount > rightItemCount) || 
        (!pickedLeft && rightItemCount > leftItemCount)) {
      points++;
    }

    if (questionCount < maxQuestions - 1) {
      setState(() {
        questionCount++;
        randomizeItemCount();
      });
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => ScorePage(points: points),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Compare Items'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Which side has more items?',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Expanded Left side items with GestureDetector
                Expanded(
                  child: GestureDetector(
                    onTap: () => verifyAnswer(true),
                    child: Container(
                      color: Colors.transparent, // Make the hitbox visible for debugging
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(leftItemCount, (index) {
                          return Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: CircleAvatar(backgroundColor: Colors.blue),
                          );
                        }),
                      ),
                    ),
                  ),
                ),
                // Expanded Right side items with GestureDetector
                Expanded(
                  child: GestureDetector(
                    onTap: () => verifyAnswer(false),
                    child: Container(
                      color: Colors.transparent, // Make the hitbox visible for debugging
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(rightItemCount, (index) {
                          return Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: CircleAvatar(backgroundColor: Colors.red),
                          );
                        }),
                      ),
                    ),
                  ),
                ),
              ],
            ),
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
        title: Text('Game Over'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('You got $points questions correct', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
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
