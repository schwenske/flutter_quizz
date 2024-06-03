import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quizz/data/model/question_card.dart';
import 'package:flutter_quizz/data/repositories/firestore_question_rep.dart';

FirebaseAuth auth = FirebaseAuth.instance;
String userId = auth.currentUser!.uid;

class CreateQuestions extends StatefulWidget {
  const CreateQuestions({super.key});

  @override
  State<CreateQuestions> createState() => _CreateQuestionsState();
}

class _CreateQuestionsState extends State<CreateQuestions> {
  final _formKey = GlobalKey<FormState>();
  List<String> tags = ['imt101', 'imt102', 'ipwa01', 'ipwa02'];
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

  late final FirestoreQuestionRep firestoreQuestionRep;

  @override
  void initState() {
    super.initState();

    firestoreQuestionRep =
        FirestoreQuestionRep(firestore: FirebaseFirestore.instance);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("CreateQuestions"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: MediaQuery.of(context).orientation == Orientation.portrait
              ? const EdgeInsets.all(20)
              : EdgeInsets.symmetric(
                  vertical: 40,
                  horizontal: MediaQuery.of(context).size.width / 5,
                ),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                DropdownButtonFormField<String>(
                  hint: Text(
                    "Bitte wählen Sie einen Kurs aus:",
                    style: Theme.of(context).textTheme.bodyLarge,
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
                    labelText: "Question",
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
                      decoration: const InputDecoration(labelText: 'Answer'),
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
                ElevatedButton(
                    onPressed: () async {
                      currentOption[answerList[0]] = boolList[0];
                      currentOption[answerList[1]] = boolList[1];
                      currentOption[answerList[2]] = boolList[2];
                      currentOption[answerList[3]] = boolList[3];
                      _addQuestionCard();
                    },
                    child: const Text('Speichern')),
              ],
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
