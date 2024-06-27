import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quizz/data/model/question_card.dart';
import 'package:flutter_quizz/data/repositories/firestore_rep.dart';
import 'package:flutter_quizz/data/repositories/tag_rep.dart';
import 'package:flutter_quizz/screens/widgets/custom_button.dart';

FirebaseAuth auth = FirebaseAuth.instance;
String userId = auth.currentUser!.uid;
User currentUser = FirebaseAuth.instance.currentUser!;
String userName = currentUser.displayName ?? '';

class CreateQuestions extends StatefulWidget {
  const CreateQuestions({super.key});

  @override
  State<CreateQuestions> createState() => _CreateQuestionsState();
}

class _CreateQuestionsState extends State<CreateQuestions> {
  final _formKey = GlobalKey<FormState>();

  List<String> tags = tagRep;
  String? currentQuestion;
  String? currentTag;
  Map<String, bool> currentOption = <String, bool>{};
  late List<String> answerList = [
    'Antwort1',
    'Antwort2',
    'Antwort3',
    'Antwort4'
  ];
  List<bool> boolList = [false, false, false, false];
  String? currentReason;

  late final FirestoreRep firestoreQuestionRep;

  @override
  void initState() {
    super.initState();

    firestoreQuestionRep = FirestoreRep(firestore: FirebaseFirestore.instance);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Erstellen Sie eine Frage $userName",
            style: Theme.of(context).textTheme.displaySmall,
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Center(
              child: Column(
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        DropdownButtonFormField<String>(
                          hint: Text(
                            "Bitte wählen Sie einen Kurs aus:",
                            style: Theme.of(context).textTheme.bodyLarge,
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                          ),
                          items: [
                            for (int i = 0; i <= 3; i++)
                              DropdownMenuItem(
                                value: tags.elementAt(i),
                                child: Text(
                                  tags.elementAt(i),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(color: Colors.brown),
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: true,
                                ),
                              ),
                          ],
                          onChanged: (value) {
                            currentTag = value.toString();
                          },
                          validator: (value) =>
                              value == null ? "Bitte Tag auswählen" : null,
                        ),
                        TextFormField(
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(color: Colors.blue),
                          decoration: const InputDecoration(
                            labelText: "Frage",
                          ),
                          onChanged: (value) {
                            currentQuestion = value;
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Bitte Frage eingeben";
                            } else {
                              return null;
                            }
                          },
                        ),
                        for (int i = 0; i < 4; i++)
                          ListTile(
                            title: TextFormField(
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(color: Colors.blue),
                              decoration:
                                  const InputDecoration(labelText: 'Antwort'),
                              onChanged: (value) {
                                setState(() {
                                  answerList[i] = value;
                                });
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Bitte Antwort eingeben";
                                } else {
                                  return null;
                                }
                              },
                            ),
                            trailing: Checkbox(
                              value: boolList[i],
                              onChanged: (value) {
                                setState(() {
                                  boolList[i] = value!;
                                });
                              },
                            ),
                          ),
                        TextFormField(
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(color: Colors.blue),
                          decoration: const InputDecoration(
                            labelText:
                                "Erläuterungen warum was richtig und was falsch ist",
                          ),
                          onChanged: (value) {
                            currentReason = value;
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Bitte Erläuterung eingeben";
                            } else {
                              return null;
                            }
                          },
                        ),
                        CustomButton(
                            onPressed: () async {
                              currentOption[answerList[0]] = boolList[0];
                              currentOption[answerList[1]] = boolList[1];
                              currentOption[answerList[2]] = boolList[2];
                              currentOption[answerList[3]] = boolList[3];
                              _addQuestionCard();
                            },
                            label: 'Speichern')
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _addQuestionCard() async {
    if (_formKey.currentState?.validate() ?? false) {
      final questionCard = QuestionCard(
          id: 'test',
          tag: currentTag!,
          author: userId,
          question: currentQuestion!,
          options: currentOption,
          reason: currentReason!);

      try {
        await firestoreQuestionRep.addQuestionCard(questionCard);

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
  }
}
