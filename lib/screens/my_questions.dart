import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quizz/data/model/question_card.dart';
import 'package:flutter_quizz/data/repositories/firestore_rep.dart';
import 'package:flutter_quizz/screens/widgets/list_error.dart';
import 'package:flutter_quizz/screens/widgets/list_loading.dart';
import 'package:flutter_quizz/screens/widgets/question_card_list_loaded.dart';

/// Screen to display a list of questions created by the current user.
class MyQuestions extends StatefulWidget {
  const MyQuestions({super.key});

  @override
  State<MyQuestions> createState() => _MyQuestionsState();
}

class _MyQuestionsState extends State<MyQuestions> {
  /// Firestore repository instance for accessing question data.
  late final FirestoreRep firestoreQuestionRep;

  /// Future builder to fetch the user's questions.
  late Future<List<QuestionCard>> questionCardBuilder;

  @override
  void initState() {
    super.initState();
    firestoreQuestionRep = FirestoreRep(firestore: FirebaseFirestore.instance);
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
            initialData: const [], // Provide an empty list while loading
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return const ListLoading(); // Show loading indicator
                case ConnectionState.active:
                case ConnectionState.done:
                  if (snapshot.hasData) {
                    return QuestionCardListLoaded(
                        questionCards: snapshot.data!);
                  } else if (snapshot.hasError) {
                    return const ListError(
                      message: "Error fetching questions",
                    );
                  } else {
                    return const ListError(message: 'Unknown error');
                  }
              }
            },
          ),
        ),
      ),
    );
  }
}
