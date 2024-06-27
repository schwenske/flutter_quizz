import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quizz/data/model/question_card.dart';
import 'package:flutter_quizz/data/repositories/firestore_rep.dart';
import 'package:flutter_quizz/widgets/list_error.dart';
import 'package:flutter_quizz/widgets/list_loading.dart';
import 'package:flutter_quizz/widgets/question_card_single_loaded.dart';

class Quizzen extends StatefulWidget {
  final String tag;
  final int count;
  const Quizzen({super.key, required this.tag, required this.count});

  @override
  State<Quizzen> createState() => _QuizzenState();
}

class _QuizzenState extends State<Quizzen> {
  late final FirestoreRep firestoreQuestionRep;
  late Future<List<QuestionCard>> questionCardBuilder;

  @override
  void initState() {
    super.initState();
    firestoreQuestionRep = FirestoreRep(
      firestore: FirebaseFirestore.instance,
    );
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
            initialData: const [],
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return const ListLoading();
                case ConnectionState.active:
                case ConnectionState.done:
                  if (snapshot.hasData) {
                    return QuestionCardSingleLoaded(
                        questionCards: snapshot.data!);
                  } else if (snapshot.hasError) {
                    return const ListError(
                      message: "Error",
                    );
                  } else {
                    return const ListError(message: 'Error2');
                  }
              }
            },
          ),
        ),
      ),
    );
  }
}
