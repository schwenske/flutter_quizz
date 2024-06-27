import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quizz/data/model/question_card.dart';
import 'package:flutter_quizz/data/repositories/firestore_question_rep.dart';
import 'package:flutter_quizz/widgets/question_card_list_error.dart';
import 'package:flutter_quizz/widgets/question_card_list_loaded.dart';
import 'package:flutter_quizz/widgets/question_card_list_loading.dart';

class MyQuestions extends StatefulWidget {
  const MyQuestions({super.key});

  @override
  State<MyQuestions> createState() => _MyQuestionsState();
}

class _MyQuestionsState extends State<MyQuestions> {
  late final FirestoreQuestionRep firestoreQuestionRep;
  late Future<List<QuestionCard>> questionCardBuilder;

  @override
  void initState() {
    super.initState();
    firestoreQuestionRep = FirestoreQuestionRep(
      firestore: FirebaseFirestore.instance,
    );
    questionCardBuilder = firestoreQuestionRep.getQuestionCardByUserId(userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("MyQuestions"),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(24),
        child: FutureBuilder<List<QuestionCard>>(
          future: questionCardBuilder,
          initialData: const [],
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return const QuestionCardListLoading();
              case ConnectionState.active:
              case ConnectionState.done:
                if (snapshot.hasData) {
                  return QuestionCardListLoaded(questionCards: snapshot.data!);
                } else if (snapshot.hasError) {
                  return const QuestionCardListError(
                    message: "Error",
                  );
                } else {
                  return const QuestionCardListError(message: 'Error2');
                }
            }
          },
        ),
      )),
    );
  }
}
