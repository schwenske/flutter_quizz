import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quizz/data/model/question_card.dart';
import 'package:flutter_quizz/data/model/user_ranking.dart';
import 'package:flutter_quizz/data/repositories/firestore_rep.dart';
import 'package:flutter_quizz/widgets/custom_button.dart';
import 'package:flutter_quizz/widgets/question_card_single_loaded.dart';

FirebaseAuth auth = FirebaseAuth.instance;
String userId = auth.currentUser!.uid;

class QuestionCardGame extends StatefulWidget {
  final QuestionCard questionCard;
  final bool isFloatBlocked;
  final Function(bool) callBoolBack;

  const QuestionCardGame({
    super.key,
    required this.questionCard,
    required this.isFloatBlocked,
    required this.callBoolBack,
  });
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
  late final FirestoreRep firestoreQuestionRep;
  String? currentUserId;
  late int userCounter;
  late int currentCounter;

  @override
  void initState() {
    super.initState();
    firestoreQuestionRep = FirestoreRep(firestore: FirebaseFirestore.instance);
  }

  @override
  Widget build(BuildContext context) {
    bool checkAnswer = true;
    return AbsorbPointer(
      absorbing: isBlocked,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(5),
            child: Card(
              color: Colors.blue[100],
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height * 0.1,
                  minWidth: MediaQuery.of(context).size.width * 0.8,
                  maxHeight: MediaQuery.of(context).size.height * 0.15,
                  maxWidth: MediaQuery.of(context).size.width * 0.9,
                ),
                child: Text(
                  widget.questionCard.question,
                  textAlign: TextAlign.center,
                  style: DefaultTextStyle.of(context)
                      .style
                      .apply(fontSizeFactor: 1.7),
                ),
              ),
            ),
          ),
          for (int i = 0; i < widget.questionCard.options.keys.length; i++)
            Padding(
              padding: const EdgeInsets.all(8),
              child: Card(
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
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: MediaQuery.of(context).size.height * 0.1,
                      minWidth: MediaQuery.of(context).size.width * 0.8,
                      maxHeight: MediaQuery.of(context).size.height * 0.15,
                      maxWidth: MediaQuery.of(context).size.width * 0.9,
                    ),
                    child: Text(
                      widget.questionCard.options.keys.elementAt(i),
                      style: DefaultTextStyle.of(context)
                          .style
                          .apply(fontSizeFactor: 1.3),
                    ),
                  ),
                ),
              ),
            ),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: [
              CustomButton(
                  onPressed: () async {
                    setState(() {
                      isBlocked = true;
                      widget.callBoolBack(!isBlocked);
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
                      currentCounter = await checkCounter();
                      if (currentCounter == -1) {
                        currentUserId = userId;
                        currentCounter = 5;
                        _addUserRanking();
                      } else {
                        int newCounterValue = currentCounter + 5;
                        countPoints += 5;
                        await firestoreQuestionRep.updateCounter(
                            userId, newCounterValue);
                      }
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
                  label: 'bestätigen')
            ],
          )
        ],
      ),
    );
  }

  Future<void> _addUserRanking() async {
    final userRanking =
        UserRanking(id: currentUserId!, counter: currentCounter);
    try {
      await firestoreQuestionRep.addUserRanking(userRanking);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.blueGrey,
          content: Text(
            "Erfolgreich hinzugefügt",
          ),
        ),
      );
    } on Exception {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            "Fehler beim Hinzufügen",
          ),
        ),
      );
    }
    if (!mounted) return;
    Navigator.pop(context);
  }

  Future<int> checkCounter() async {
    userCounter = await firestoreQuestionRep.getUserRankingCounterById(userId);
    return userCounter;
  }
}
