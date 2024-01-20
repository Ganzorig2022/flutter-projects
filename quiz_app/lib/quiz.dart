import 'package:flutter/material.dart';
import 'package:quiz_app/data/questions.dart';
import 'package:quiz_app/questions_screen.dart';
import 'package:quiz_app/start_screen.dart';
import 'package:quiz_app/result_screen.dart';

// creating state
class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() {
    return _QuizState();
  }
}

class _QuizState extends State<Quiz> {
  var activeScreen = 'start-screen';
  List<String> _selectedAnswers = []; // declaring string typed array[]

  void switchScreen(String choice) {
    setState(() {
      activeScreen = '$choice-screen';
    });

// means need to reset values
    if (choice == 'start') {
      _selectedAnswers = [];
    }
  }

  void chooseAnswer(String answer) {
    _selectedAnswers.add(answer);

    if (_selectedAnswers.length == questions.length) {
      setState(() {
        activeScreen = 'result-screen';
      });
    }
  }

  @override
  Widget build(context) {
    Widget screenWidget =
        StartScreen(switchScreen); // sending function as props

    if (activeScreen == 'questions-screen') {
      screenWidget = QuestionsScreen(
        onSelectAnswer: chooseAnswer,
      ); // sending function as props, but receives data from it (LIFTING UP)...
    }

    if (activeScreen == 'result-screen') {
      screenWidget = ResultScreen(
          chosenAnswers: _selectedAnswers,
          onSwitchScreen: switchScreen); // sending array[] as props
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
