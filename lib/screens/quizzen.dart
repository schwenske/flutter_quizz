import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quizz/data/model/question_card.dart';
import 'package:flutter_quizz/data/repositories/firestore_rep.dart';
import 'package:flutter_quizz/screens/widgets/list_error.dart';
import 'package:flutter_quizz/screens/widgets/list_loading.dart';
import 'package:flutter_quizz/screens/widgets/question_card_single_loaded.dart';

/// Screen for displaying a quiz based on a given tag and question count.
class Quizzen extends StatefulWidget {
  final String tag;
  final int count;

  const Quizzen({super.key, required this.tag, required this.count});

  @override
  State<Quizzen> createState() => _QuizzenState();
}

class _QuizzenState extends State<Quizzen> {
  /// Firestore repository instance for accessing question data.
  late final FirestoreRep firestoreQuestionRep;

  /// Future builder to fetch the questions for the quiz.
  late Future<List<QuestionCard>> questionCardBuilder;

  @override
  void initState() {
    super.initState();
    firestoreQuestionRep = FirestoreRep(firestore: FirebaseFirestore.instance);
    questionCardBuilder = firestoreQuestionRep.getQuestionCardByTagAndCount(
        widget.tag, widget.count);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    return QuestionCardSingleLoaded(
                      questionCards: snapshot.data!,
                    );
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
