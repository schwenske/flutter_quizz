import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quizz/data/model/question_card.dart';
import 'package:flutter_quizz/data/model/user_ranking.dart';
import 'package:flutter_quizz/data/repositories/firestore_rep.dart';
import 'package:flutter_quizz/screens/widgets/custom_button.dart';
import 'package:flutter_quizz/screens/widgets/question_card_single_loaded.dart';
import 'package:url_launcher/url_launcher_string.dart';

/// Retrieves the currently authenticated user and their ID.
FirebaseAuth auth = FirebaseAuth.instance;
String userId = auth.currentUser!.uid;
User currentUser = FirebaseAuth.instance.currentUser!;
String userName = currentUser.displayName ?? 'unknown User';

/// Represents a single question card within the quiz game.
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

// Global variables to manage the state of the question card game
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

/// Manages the state and logic for the QuestionCardGame widget.
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
    return Column(
      children: [
        AbsorbPointer(
          absorbing: isBlocked, // Disables input if isBlocked is true
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
                      widget.questionCard.question, // Displays the question
                      textAlign: TextAlign.center,
                      style: DefaultTextStyle.of(context)
                          .style
                          .apply(fontSizeFactor: 1.7),
                    ),
                  ),
                ),
              ),
              // Loops through the options and displays them as cards
              for (int i = 0; i < widget.questionCard.options.keys.length; i++)
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Card(
                    color: gameCardColor[i], // Sets the color of the card
                    child: InkWell(
                      splashColor: Colors.blue,
                      onTap: () {
                        setState(() {
                          // Toggles the color and state of the option when tapped
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
                          widget.questionCard.options.keys
                              .elementAt(i), // Displays the option text
                          style: DefaultTextStyle.of(context)
                              .style
                              .apply(fontSizeFactor: 1.3),
                        ),
                      ),
                    ),
                  ),
                ),
              // Button bar with a custom button to submit the answers
              ButtonBar(
                alignment: MainAxisAlignment.center,
                children: [
                  CustomButton(
                      onPressed: () async {
                        setState(() {
                          isBlocked = true; // Blocks further input
                          widget.callBoolBack(!isBlocked);
                        });
                        // Checks the answers
                        for (int i = 0;
                            i < widget.questionCard.options.keys.length;
                            i++) {
                          if ((gameCardColor[i] == Colors.green) &&
                              (widget.questionCard.options.values
                                      .elementAt(i) ==
                                  gameCardCurrentBool[i])) {
                            correctAnswer[i] = true;
                          } else if ((gameCardColor[i] == Colors.white) &&
                              (widget.questionCard.options.values
                                      .elementAt(i) ==
                                  gameCardCurrentBool[i])) {
                            correctAnswer[i] = true;
                          } else {
                            // If the answer is incorrect, mark it as false
                            correctAnswer[i] = false;
                          }
                        }
                        // Check if any answer is incorrect
                        for (int i = 0; i < correctAnswer.length; i++) {
                          if (correctAnswer[i] == false) {
                            checkAnswer = false;
                          }
                        }
                        if (checkAnswer == false) {
                          widget.questionCard.options.forEach((key, value) {
                            if (!value) {
                              answerList.add(
                                  key); // Add incorrect answers to the list
                            }
                          });
                          // Show a dialog with the incorrect answers
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text(
                                      'The following answers are incorrect:'),
                                  content: SingleChildScrollView(
                                    child: ListBody(
                                      children: [
                                        for (int i = 0;
                                            i < answerList.length;
                                            i++)
                                          Text(answerList[i]),
                                        Text(
                                            '\nPlease note the following reason ${widget.questionCard.reason}'),
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
                          // If all answers are correct, update the user's score and ranking
                          currentCounter = await checkCounter();
                          if (currentCounter == -1) {
                            currentUserId = userId;
                            currentCounter = 5;
                            countPoints += 5;
                            _addUserRanking();
                          } else {
                            int newCounterValue = currentCounter + 5;
                            countPoints += 5;
                            await firestoreQuestionRep.updateCounter(
                                userId, newCounterValue);
                          }
                          // Show a dialog with a success message
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text(
                                      '$userName, you answered everything correctly'),
                                  content: const SingleChildScrollView(
                                    child: ListBody(
                                      children: [
                                        Text('You receive 5 points'),
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
                      label: 'confirm'),
                ],
              )
            ],
          ),
        ),
        // Button to report a question
        CustomButton(
            onPressed: () {
              _mailto(widget.questionCard.id, userId);
            },
            label: 'Report Question')
      ],
    );
  }

  // Adds the user ranking to Firestore
  Future<void> _addUserRanking() async {
    final userRanking = UserRanking(
        id: currentUserId!, counter: currentCounter, username: userName);
    try {
      await firestoreQuestionRep.addUserRanking(userRanking);
      if (!mounted) return;
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('$userName, you answered everything correctly'),
              content: const SingleChildScrollView(
                child: ListBody(
                  children: [
                    Text('You receive 5 points'),
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
    } on Exception {
      print('Error adding user ranking');
    }
    if (!mounted) return;
    Navigator.pop(context);
  }

  // Checks the user's counter value from Firestore
  Future<int> checkCounter() async {
    userCounter = await firestoreQuestionRep.getUserRankingCounterById(userId);
    return userCounter;
  }
}

// Launches an email client to report a question
_mailto(String questionCardId, String userId) async {
  final url =
      'mailto:flutter-quizz-a9ab4@web.de?subject=Reporting a Question&body=QuestionCardId: $questionCardId - reported by User: $userId%0APlease explain the issue:';
  if (await canLaunchUrlString(url)) {
    await launchUrlString(url);
  } else {
    throw 'Could not launch $url';
  }
}
