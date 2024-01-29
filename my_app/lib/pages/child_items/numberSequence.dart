import 'package:flutter/material.dart';

class NumberSequencePage extends StatefulWidget {
  @override
  _NumberSequencePageState createState() => _NumberSequencePageState();
}

class _NumberSequencePageState extends State<NumberSequencePage> {
  List<SequenceQuestion> questions = [
    SequenceQuestion([1, 2, 3], 4, [4, 5, 6, 7]),
    SequenceQuestion([5, 6, 7], 8, [8, 9, 10, 11]),
    SequenceQuestion([10, 11, 12], 13, [13, 14, 15, 16]),
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

  void verifyAnswer(int selectedNumber) {
    final SequenceQuestion currentQuestion = questions[currentQuestionIndex];
    if (selectedNumber == currentQuestion.missingNumber) {
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
    final SequenceQuestion currentQuestion = questions[currentQuestionIndex];
    List<int> sequenceDisplay = List.from(currentQuestion.sequence);
    sequenceDisplay.add(-1); // Placeholder for the missing number

    return Scaffold(
      appBar: AppBar(
        title: Text('Missing Number Game'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: sequenceDisplay.map((number) {
                return number == -1
                    ? Text(
                        "_",
                        style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                      )
                    : Text(
                        number.toString(),
                        style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                      );
              }).toList(),
            ),
            SizedBox(height: 24),
            Text(
              'Tap the missing number',
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24),
            Wrap(
              spacing: 8.0, // gap between adjacent chips
              runSpacing: 8.0, // gap between lines
              alignment: WrapAlignment.spaceEvenly,
              children: currentQuestion.options.map((option) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                      onPressed: () => verifyAnswer(option),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 20.0),
                      ),
                      child: Text(option.toString(), style: TextStyle(fontSize: 20)),
                    ),
              )).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class SequenceQuestion {
  final List<int> sequence;
  final int missingNumber;
  final List<int> options;

  SequenceQuestion(this.sequence, this.missingNumber, this.options);
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
