### Importing package

```dart
import 'package:flutter/material.dart';
import 'package:first_app/gradient_container.dart'; // custom widget
```

### ASSETS folder

`1.` pubspec.yaml file dotor image-uudee import zaaj ogno.

```yaml
assets:
  - assets/images/dice-1.png
  - assets/images/dice-2.png
  - assets/images/dice-3.png
  - assets/images/dice-4.png
  - assets/images/dice-5.png
  - assets/images/dice-6.png
```

### Creating custom Widget

```dart
import 'package:flutter/material.dart'; // must import

class StyledText extends StatelessWidget {
  const StyledText({super.key}); // must add

  @override
  Widget build(context) {
    return const Text(
      'Hello Ganzo',
      style: TextStyle(
        color: Colors.white,
        fontSize: 28,
      ),
    );
  }
}

```

### Creating Stateful Widget

> [Link](https://api.flutter.dev/flutter/widgets/StatefulWidget-class.html?gclid=Cj0KCQiAhc-sBhCEARIsAOVwHuRcjhtSUFqDleKMnTRk1lrXOSUrqxuCIPC0PxzgTztW2R5lFsXGORoaAqBkEALw_wcB&gclsrc=aw.ds)

```dart
import 'package:flutter/material.dart';
import 'package:quiz_app/data/questions.dart';
import 'package:quiz_app/questions_screen.dart';
import 'package:quiz_app/start_screen.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});
  @override
  State<Quiz> createState() {
    return _QuizState();
  }
}

class _QuizState extends State<Quiz> {
  var activeScreen = 'start-screen';
  List<String> selectedAnswers = []; // declaring string typed array[]

  void switchScreen() {
    setState(() {
      activeScreen = 'questions-screen';
    });
  }

  void chooseAnswer(String answer) {
    selectedAnswers.add(answer);

    if (selectedAnswers.length == questions.length) {
      setState(() {
        activeScreen = 'start-screen';
        selectedAnswers = [];
      });
    }
  }

  @override
  Widget build(context) {
    Widget screenWidget =
        StartScreen(switchScreen); // sending function as props

    if (activeScreen == 'questions-screen') {
      screenWidget = QuestionsScreen(
          onSelectAnswer:
              chooseAnswer); // sending function as props, but receives data from it (LIFTING UP)...
    }

    return MaterialApp(
      home: Scaffold(
        body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.deepPurple, Color.fromARGB(255, 65, 12, 126)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight),
            ),
            child: screenWidget),
      ),
    );
  }
}

```

### Variables

> Parent component

```dart
import 'package:first_app/styled_text.dart';
import 'package:flutter/material.dart';

const startAlignment = Alignment.topLeft;
const endAlignment = Alignment.bottomRight;

class GradientContainer extends StatelessWidget {
  const GradientContainer({super.key});

  @override
  Widget build(context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(colors: [
          Color.fromARGB(255, 26, 2, 80),
          Color.fromARGB(255, 45, 7, 98),
        ], begin: startAlignment, end: endAlignment),
      ),
      child: const Center(
        child: StyledText('Hello Ganzorig'), // sending text props
      ),
    );
  }
}

```

> Child component

```dart
import 'package:flutter/material.dart';

class StyledText extends StatelessWidget {
  const StyledText(this.outputText, {super.key}); // 1. dynamic text props

  final String outputText; // 2. assigning to variable

  @override
  Widget build(context) {
    return Text(
      outputText, // 3. then use it
      style: const TextStyle(
        color: Colors.white,
        fontSize: 28,
      ),
    );
  }
}
```

### Passing Function as Props, Lifting State Up

`1.` **_Parent element_**. 'quiz.dart' file-aas 'questions-screen.dart' file ruu

```dart
// Parent element.
 if (activeScreen == 'questions-screen') {
      screenWidget = QuestionsScreen(
          onSelectAnswer:
              chooseAnswer); // sending function as props, but receives data from it (LIFTING UP)...
    }
```

`2.` **_Child element_**.

```dart

// Child element.
class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen(
      {super.key, required this.onSelectAnswer}); // receiving props from parent

  final void Function(String answer) onSelectAnswer;

  @override
  State<QuestionsScreen> createState() {
    return _QuestionsScreenState();
  }
}
```

### Maps in dart

`1.` It is like Object in javascript.

```dart
import 'package:flutter/material.dart';
import 'package:quiz_app/data/questions.dart';
import 'package:quiz_app/questions_summary.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen(
      {super.key,
      required this.chosenAnswers}); // 1. receiving array[] props from parent

  final List<String> chosenAnswers; // 2. defining props type

  List<Map<String, Object>> getSummaryData() {
    final List<Map<String, Object>> summary = [];

    for (var i = 0; i < chosenAnswers.length; i++) {
      summary.add(
        {
          'question_index': i,
          'question': questions[i].text,
          'correct_answer': questions[i].answers[0],
          'user_answer': chosenAnswers[i]
        },
      );
    }

    return summary;
  }

  @override
  Widget build(BuildContext context) {
    final summaryData = getSummaryData();
    final numTotalQuestions = questions.length;
    final numCorrectQuestions = summaryData
        .where((data) => data['user_answer'] == data['correct_answer'])
        .length;

    return SizedBox(
        width: double.infinity, // use enough width as much as possible
        child: Container(
          margin: const EdgeInsets.all(40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                  'You answered $numCorrectQuestions out of $numTotalQuestions questions correctly!'),
              const SizedBox(
                height: 30,
              ),
              QuestionsSummary(summaryData),
              const SizedBox(
                height: 30,
              ),
              TextButton(
                onPressed: () {},
                child: const Text('Restart Quiz'),
              )
            ],
          ),
        ));
  }
}

```

### Installing 3rd Package

```sh
# Installing uuid generator
flutter pub add uuid

# Installing date time formatter. https://pub.dev/packages/intl
flutter pub add intl
```
