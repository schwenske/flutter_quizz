import 'package:flutter/material.dart';
import 'package:flutter_quizz/data/model/question_card.dart';
import 'package:flutter_quizz/data/model/question_condition.dart';

class QuestionCardGame extends StatefulWidget {
  final QuestionCard questionCard;
  final QuestionCondition questionCondition;

  const QuestionCardGame(
      {super.key, required this.questionCard, required this.questionCondition});

  @override
  State<QuestionCardGame> createState() => _QuestionCardGameState();
}

class _QuestionCardGameState extends State<QuestionCardGame> {
  @override
  Widget build(BuildContext context) {
    bool checkAnswer = true;
    List<Color> gameCardColor = widget.questionCondition.currentColor;
    bool enableWriteCondition = widget.questionCondition.writeCondition;
    List<bool> gameCardCurrentBool = widget.questionCondition.currentBool;
    List<bool> correctAnswer = [false, false, false, false];
    return Column(
      children: [
        Text(widget.questionCard.question),
        for (int i = 0; i < widget.questionCard.options.keys.length; i++)
          Card(
            color: gameCardColor[i],
            child: InkWell(
              splashColor: Colors.blue,
              onTap: () {
                setState(() {
                  if (enableWriteCondition == true) {
                    if (gameCardColor[i] == Colors.white) {
                      gameCardColor[i] = Colors.green;
                      gameCardCurrentBool[i] = true;
                    } else {
                      gameCardColor[i] = Colors.white;
                      gameCardCurrentBool[i] = false;
                    }
                  } else {}
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
                if (enableWriteCondition == false) {
                } else {
                  for (int i = 0;
                      i < widget.questionCard.options.keys.length;
                      i++) {
                    if ((gameCardColor[i] == Colors.green) &&
                        (widget.questionCard.options.values.elementAt(i) ==
                            gameCardCurrentBool[i])) {
                      correctAnswer[i] = true;
                    } else if ((gameCardColor[i] == Colors.white) &&
                        (widget.questionCard.options.values.elementAt(i) ==
                            gameCardCurrentBool[i])) {
                      correctAnswer[i] = true;
                    } else {}
                  }
                  for (int i = 0; i < correctAnswer.length; i++) {
                    if (correctAnswer[i] == false) {
                      checkAnswer = false;
                    } else {}
                  }
                  print(checkAnswer);
                  if (checkAnswer == false) {
                    widget.questionCard.options.forEach((key, value) {
                      if (!value) {
                        widget.questionCondition.answerList.add(key);
                      }
                    });
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title:
                                const Text('Folgende Antworten sind falsch:'),
                            content: SingleChildScrollView(
                              child: ListBody(
                                children: [
                                  for (int i = 0;
                                      i <
                                          widget.questionCondition.answerList
                                              .length;
                                      i++)
                                    Text(
                                        widget.questionCondition.answerList[i]),
                                  Text(
                                      'Bitte beachten Sie dabei folgenden Grund ${widget.questionCard.reason}'),
                                ],
                              ),
                            ),
                            actions: [
                              TextButton(
                                  child: const Text('ok'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  })
                            ],
                          );
                        });
                  } else {
                    print('Sie erhalten 5 Punkte');
                  }
                  print('erfolg1');
                }
                enableWriteCondition = false;
              },
              child: const Text('bestätigen'),
            ),
          ],
        )
      ],
    );
  }
}
