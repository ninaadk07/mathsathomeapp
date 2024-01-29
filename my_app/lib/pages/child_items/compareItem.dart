import 'package:flutter/material.dart';
import 'dart:math' as math;


class CompareItemsPage extends StatefulWidget {
  @override
  _CompareItemsPageState createState() => _CompareItemsPageState();
}

class _CompareItemsPageState extends State<CompareItemsPage> {
  List<Question> questions = [
    Question(3, 5),
    Question(2, 4),
    Question(6, 1),
    Question(8, 9)
    // Add more questions as needed
  ];

  int currentQuestionIndex = 0;
  int points = 0;
  final Stopwatch stopwatch = Stopwatch();

  @override
  void initState() {
    super.initState();
    stopwatch.start();
  }

  void verifyAnswer(bool pickedLeft) {
    final currentQuestion = questions[currentQuestionIndex];
    if ((pickedLeft && currentQuestion.left > currentQuestion.right) ||
        (!pickedLeft && currentQuestion.right > currentQuestion.left)) {
      points++;
    }

    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
      });
    } else {
      stopwatch.stop();
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => ScorePage(points: points, timeElapsed: stopwatch.elapsed),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = questions[currentQuestionIndex];
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
              children: [
                // Left side GestureDetector
                Expanded(
                  child: GestureDetector(
                    onTap: () => verifyAnswer(true),
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      color: Colors.transparent,
                      child: buildItemLayout(currentQuestion.left, Colors.blue),
                    ),
                  ),
                ),
                // Divider
                VerticalDivider(
                  color: Colors.grey,
                  width: 1,
                  thickness: 1,
                ),
                // Right side GestureDetector
                Expanded(
                  child: GestureDetector(
                    onTap: () => verifyAnswer(false),
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      color: Colors.transparent,
                      child: buildItemLayout(currentQuestion.right, Colors.red),
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

  Widget buildItemLayout(int itemCount, Color color) {
    return LayoutBuilder(
      builder: (context, constraints) {
        List<Widget> items = [];
        math.Random random = math.Random();

        int radius = 20; // Radius of the circles
        int diameter = radius * 2;
        int padding = 4; // Padding around each circle
        int cellSize = diameter + padding; // Size of each grid cell

        // Adjusted to account for the diameter of the circles
        int gridColumns = ((constraints.maxWidth - diameter) / cellSize).floor();
        int gridRows = ((constraints.maxHeight - diameter) / cellSize).floor();
        
        List<List<bool>> grid = List.generate(gridRows, (_) => List.generate(gridColumns, (_) => false));

        while (items.length < itemCount) {
          int gridColumn = random.nextInt(gridColumns);
          int gridRow = random.nextInt(gridRows);

          // Check if the grid cell is already occupied
          if (!grid[gridRow][gridColumn]) {
            grid[gridRow][gridColumn] = true; // Mark the grid cell as occupied
            
            double x = gridColumn * cellSize + radius + padding / 2;
            double y = gridRow * cellSize + radius + padding / 2;
            items.add(Positioned(
              left: x,
              top: y,
              child: CircleAvatar(backgroundColor: color, radius: radius.toDouble()),
            ));
          }
        }
        return Stack(children: items);
      },
    );
  }
}

class Question {
  final int left;
  final int right;

  Question(this.left, this.right);
}

class ScorePage extends StatelessWidget {
  final int points;
  final Duration timeElapsed;

  const ScorePage({Key? key, required this.points, required this.timeElapsed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Completed'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('You got $points questions correct', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Text('Time taken: ${timeElapsed.inSeconds} seconds', style: TextStyle(fontSize: 20)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Continue'),
            ),
          ],
        ),
      ),
    );
  }
}

// Custom Point class to represent grid positions
class Point {
  final int x;
  final int y;

  Point(this.x, this.y);

  @override
  bool operator ==(Object other) =>
      other is Point && other.x == x && other.y == y;

  @override
  int get hashCode => x.hashCode ^ y.hashCode;
}