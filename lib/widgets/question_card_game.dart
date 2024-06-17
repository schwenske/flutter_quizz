import 'package:flutter/material.dart';
import 'package:flutter_quizz/data/model/question_card.dart';

class QuestionCardGame extends StatefulWidget {
  final QuestionCard questionCard;

  const QuestionCardGame({super.key, required this.questionCard});

  @override
  State<QuestionCardGame> createState() => _QuestionCardGameState();
}

bool isBlocked = false;
List<Color> gameCardColor = [
  Colors.white,
  Colors.white,
  Colors.white,
  Colors.white
];
List<bool> gameCardCurrentBool = [false, false, false, false];
List<bool> correctAnswer = [false, false, false, false];
List<String> answerList = [];

class _QuestionCardGameState extends State<QuestionCardGame> {
  @override
  Widget build(BuildContext context) {
    bool checkAnswer = true;
    return AbsorbPointer(
      absorbing: isBlocked,
      child: Column(
        children: [
          Text(widget.questionCard.question),
          for (int i = 0; i < widget.questionCard.options.keys.length; i++)
            Card(
              color: gameCardColor[i],
              child: InkWell(
                splashColor: Colors.blue,
                onTap: () {
                  setState(() {
                    if (gameCardColor[i] == Colors.white) {
                      gameCardColor[i] = Colors.green;
                      gameCardCurrentBool[i] = true;
                    } else {
                      gameCardColor[i] = Colors.white;
                      gameCardCurrentBool[i] = false;
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
                  setState(() {
                    isBlocked = true;
                  });
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
                  if (checkAnswer == false) {
                    widget.questionCard.options.forEach((key, value) {
                      if (!value) {
                        answerList.add(key);
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
                                  for (int i = 0; i < answerList.length; i++)
                                    Text(answerList[i]),
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
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text(
                                'Sie haben alles richtig beantwortet'),
                            content: const SingleChildScrollView(
                              child: ListBody(
                                children: [
                                  Text('Sie erhalten 5 Punkte'),
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
                  }
                },
                child: const Text('bestätigen'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
