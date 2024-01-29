import 'package:flutter/material.dart';

class OneDigitSubtractionPage extends StatefulWidget {
  @override
  _OneDigitSubtractionPageState createState() => _OneDigitSubtractionPageState();
}

class _OneDigitSubtractionPageState extends State<OneDigitSubtractionPage> {
  List<SubtractionQuestion> questions = [
    SubtractionQuestion(6, null, [5, 7]),  // Single number question with options
    SubtractionQuestion(3, 1, [2, 4]),     // Two numbers question with options
    SubtractionQuestion(7, 4, [3, 5]),     // Two numbers question with options
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
        title: Text('One-Digit Subtraction Game'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              currentQuestion.questionText,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24),
            Wrap(
              spacing: 16.0,
              runSpacing: 16.0,
              alignment: WrapAlignment.center,
              children: currentQuestion.options.map((option) => Padding(
                padding: const EdgeInsets.all(8.0),
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

class SubtractionQuestion {
  final int firstNumber;
  final int? secondNumber;
  final List<int> options;

  SubtractionQuestion(this.firstNumber, this.secondNumber, this.options);

  bool get isSingleNumber => secondNumber == null;

  int get answer => isSingleNumber ? firstNumber - 1 : firstNumber - secondNumber!;

  String get questionText {
    if (isSingleNumber) {
      return 'Tap the number one less than $firstNumber';
    } else {
      return 'Solve the subtraction: $firstNumber - $secondNumber';
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
