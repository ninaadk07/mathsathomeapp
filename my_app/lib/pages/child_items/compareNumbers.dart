import 'package:flutter/material.dart';

class CompareNumbersPage extends StatefulWidget {
  @override
  _CompareNumbersPageState createState() => _CompareNumbersPageState();
}

class _CompareNumbersPageState extends State<CompareNumbersPage> {
  List<Question> questions = [
    Question(3, 5),
    Question(2, 4),
    Question(6, 1),
    // ... additional questions
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
        title: Text('Compare Numbers'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Which number is bigger?',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                numberDisplay(currentQuestion.left, true),
                VerticalDivider(
                  color: Colors.grey,
                  width: 1,
                  thickness: 1,
                ),
                numberDisplay(currentQuestion.right, false),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget numberDisplay(int number, bool isLeft) {
    return Expanded(
      child: GestureDetector(
        onTap: () => verifyAnswer(isLeft),
        behavior: HitTestBehavior.opaque,
        child: Center(
          child: Text(
            number.toString(),
            style: TextStyle(fontSize: 48, color: Colors.black),
          ),
        ),
      ),
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
