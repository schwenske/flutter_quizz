import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quizz/data/model/question_card.dart';
import 'package:flutter_quizz/data/repositories/firestore_question_rep.dart';

class CreateQuestions extends StatefulWidget {
  const CreateQuestions({super.key});

  @override
  State<CreateQuestions> createState() => _CreateQuestionsState();
}

class _CreateQuestionsState extends State<CreateQuestions> {
  final _formKey = GlobalKey<FormState>();

  String? currentQuestion;
  Map<String, bool> currentOption = <String, bool>{};

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
                for (var i = 0; i < 4; i++)
                  ListTile(
                    title: TextFormField(
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: Colors.blue),
                      decoration: InputDecoration(labelText: 'Answer ${i + 1}'),
                      onSaved: (value) {
                        setState(() {
                          currentOption['Answer ${i + 1}'] = true;
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
                      value: currentOption['Antwort ${i + 1}'] ?? false,
                      onChanged: (value) {
                        setState(() {
                          currentOption['Antwort ${i + 1}'] = value!;
                        });
                      },
                    ),
                  ),
                ElevatedButton(
                    onPressed: () => _addQuestionCard(),
                    child: Text('Speichern')),
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
          id: 'test', question: currentQuestion!, options: currentOption);

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
