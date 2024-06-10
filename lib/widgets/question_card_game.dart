import 'package:flutter/material.dart';
import 'package:flutter_quizz/data/model/question_card.dart';

class QuestionCardGame extends StatefulWidget {
  final QuestionCard questionCard;
  final List<Color> color;
  final List<bool> currentBool;
  const QuestionCardGame(
      {super.key,
      required this.questionCard,
      required this.color,
      required this.currentBool});

  @override
  State<QuestionCardGame> createState() => _QuestionCardGameState();
}

class _QuestionCardGameState extends State<QuestionCardGame> {
  List<bool> correctAnswer = [false, false, false, false];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(widget.questionCard.question),
        for (int i = 0; i < widget.questionCard.options.keys.length; i++)
          Card(
            color: widget.color[i],
            child: InkWell(
              splashColor: Colors.blue,
              onTap: () {
                setState(() {
                  if (widget.color[i] == Colors.white) {
                    widget.color[i] = Colors.green;
                    widget.currentBool[i] = true;
                  } else if (widget.color[i] == Colors.green) {
                    widget.color[i] = Colors.red;
                    widget.currentBool[i] = false;
                  } else {
                    widget.color[i] = Colors.green;
                    widget.currentBool[i] = true;
                  }
                });
              },
              child: SizedBox(
                child: Text(widget.questionCard.options.keys.elementAt(i)),
              ),
            ),
          ),
        ButtonBar(
          children: [
            ElevatedButton(
              onPressed: () {
                for (int i = 0;
                    i < widget.questionCard.options.keys.length;
                    i++) {
                  if ((widget.color[i] != Colors.white) &&
                      (widget.questionCard.options.values.elementAt(i) ==
                          widget.currentBool[i])) {
                    correctAnswer[i] = true;
                  } else if ((widget.color[i] != Colors.white) &&
                      (widget.questionCard.options.values.elementAt(i) !=
                          widget.currentBool[i])) {
                    correctAnswer[i] = false;
                  } else {
                    print('Error3');
                  }
                }
                correctAnswer.forEach((answer) {
                  if (answer != true) {
                    print('Diese Antwort ist falsch $answer');
                  } else {
                    print('Diese Antwort ist richtig $answer');
                  }
                });
              },
              child: const Text('bestätigen'),
            ),
          ],
        )
      ],
    );
  }
}
