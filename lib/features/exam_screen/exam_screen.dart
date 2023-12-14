import 'package:dmiti_project/core/alert_dialog.dart';
import 'package:dmiti_project/core/algorithms/evklid_classes.dart';
import 'package:dmiti_project/core/full_task.dart';
import 'package:dmiti_project/res/colors.dart';
import 'package:dmiti_project/res/theme.dart';
import 'package:flutter/material.dart';

class CustomScaffold extends StatelessWidget {
  final Widget body;

  CustomScaffold({required this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 250, 252, 254),
        title: SizedBox(
          child: Column(
            children: [
              Center(
                child: Text(
                  "Тестирование",
                  style: getTheme().textTheme.headlineLarge,
                ),
              ),
            ],
          ),
        ),
      ),
      body: body,
    );
  }
}

class TaskScreen extends StatefulWidget {
  final List<Task> tasks;

  TaskScreen({required this.tasks});

  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  List<int> _incorrectTasks = [];
  int _currentIndex = 0;
  int _correctAnswers = 0;

  void _nextTask() {
    setState(() {
      _currentIndex++;
    });
  }

  void _checkAnswer(bool isCorrect) {
    if (isCorrect) {
      _correctAnswers++;
    }
    if (!isCorrect) {
      _incorrectTasks.add(_currentIndex);
    } else {
      _incorrectTasks.remove(_currentIndex);
    }
    _nextTask();
  }

  @override
  Widget build(BuildContext context) {
    if (_currentIndex >= widget.tasks.length) {
      return CustomScaffold(
        body: Center(
            child: DefaultDialog(
                context: context,
                colorButton: AppColors.green,
                mainText: "Результаты теста",
                infoText:
                    "Ваш результат: $_correctAnswers\nНеправильно решенные задачи: ${_incorrectTasks.map((index) => index + 1).join(', ')}",
                buttonText: "Начать заново",
                onPressedFunction: () {
                  setState(() {
                    _currentIndex = _incorrectTasks[0];
                    //_correctAnswers = 0;
                    _incorrectTasks.clear();
                  });
                })),
      );
    }
    return CustomScaffold(
      body: Center(
        child: FullTask(
          isSolved: false,
          taskGenerator: widget.tasks[_currentIndex],
          isExample: false,
          onAnswer: _checkAnswer,
          isEducation: false,
        ),
      ),
    );
  }
}
