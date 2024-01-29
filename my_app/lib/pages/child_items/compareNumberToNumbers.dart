import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Number Comparison Game',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CompareNumberToNumbersPage(),
    );
  }
}

class CompareNumberToNumbersPage extends StatefulWidget {
  @override
  _CompareNumberPageState createState() => _CompareNumberPageState();
}

class _CompareNumberPageState extends State<CompareNumberToNumbersPage> {
  List<Question> questions = [
    Question(3, 5, 3), // left, right, target
    Question(4, 2, 4),
    Question(1, 6, 1),
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
    bool correctAnswer = (pickedLeft && currentQuestion.left == currentQuestion.targetNumber) ||
                         (!pickedLeft && currentQuestion.right == currentQuestion.targetNumber);
    
    if (correctAnswer) {
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
        title: Text('Number Comparison'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Which side has the number ${currentQuestion.targetNumber}?',
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
                    child: Center(
                      child: Text(
                        currentQuestion.left.toString(),
                        style: TextStyle(fontSize: 36, color: Colors.black),
                      ),
                    ),
                  ),
                ),
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
                    child: Center(
                      child: Text(
                        currentQuestion.right.toString(),
                        style: TextStyle(fontSize: 36, color: Colors.black),
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

class Question {
  final int left;
  final int right;
  final int targetNumber;

  Question(this.left, this.right, this.targetNumber);
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
