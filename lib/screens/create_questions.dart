import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quizz/data/repositories/firestore_question_rep.dart';

class CreateQuestions extends StatefulWidget {
  const CreateQuestions({super.key});

  @override
  State<CreateQuestions> createState() => _CreateQuestionsState();
}

class _CreateQuestionsState extends State<CreateQuestions> {
  final _formKey = GlobalKey<FormState>();

  String? currentQuestion;
  String? currentOption;

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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
