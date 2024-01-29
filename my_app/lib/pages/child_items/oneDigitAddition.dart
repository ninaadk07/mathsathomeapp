import 'package:flutter/material.dart';

class OneDigitAdditionPage extends StatefulWidget {
  @override
  _OneDigitAdditionPageState createState() => _OneDigitAdditionPageState();
}

class _OneDigitAdditionPageState extends State<OneDigitAdditionPage> {
  List<AdditionQuestion> questions = [
    AdditionQuestion(5, null, [6, 7]),  // Single number question with options
    AdditionQuestion(3, 1, [4, 5]),  // Two numbers question with options
    AdditionQuestion(4, 5, [9, 10]),  // Two numbers question with options
    // ...other questions
  ];

  int currentQuestionIndex = 0;
  int points = 0;
  final Stopwatch stopwatch = Stopwatch();

  @override
  void initState() {
    super.initState();
    stopwatch.start();
  }

  void verifyAnswer(int userAnswer) {
    final currentQuestion = questions[currentQuestionIndex];
    if (userAnswer == currentQuestion.answer) {
      points++;
    }
    // Proceed to the next question or end the game
    setState(() {
      if (currentQuestionIndex < questions.length - 1) {
        currentQuestionIndex++;
      } else {
        stopwatch.stop();
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => ScorePage(points: points, timeElapsed: stopwatch.elapsed),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = questions[currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text('One-Digit Addition Game'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Centers along the main axis
          crossAxisAlignment: CrossAxisAlignment.stretch, // Stretches the column to fill the screen width
          children: [
            Text(
              currentQuestion.questionText,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24),
            Wrap(
              spacing: 16.0, // Horizontal space between buttons
              runSpacing: 16.0, // Vertical space between buttons
              alignment: WrapAlignment.center, // Centers the buttons within the Wrap
              children: currentQuestion.options.map((option) => Padding(
                padding: const EdgeInsets.all(8.0), // Padding around each button
                child: ElevatedButton(
                  onPressed: () => verifyAnswer(option),
                  child: Text(option.toString(), style: TextStyle(fontSize: 20)),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                  ),
                ),
              )).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class AdditionQuestion {
  final int firstNumber;
  final int? secondNumber;
  final List<int> options;

  AdditionQuestion(this.firstNumber, this.secondNumber, this.options);

  int get answer => secondNumber != null ? firstNumber + secondNumber! : firstNumber + 1;

  String get questionText {
    if (secondNumber != null) {
      return 'Solve the addition: $firstNumber + $secondNumber';
    } else {
      return 'Tap the number one more than $firstNumber';
    }
  }
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
            Text('You scored $points points', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
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
