import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_quizz/data/model/question_card.dart';
import 'package:flutter_quizz/data/repositories/question_rep.dart';

const questionCardCollection = "questionCards";

class FirestoreQuestionRep implements QuestionRep {
  final FirebaseFirestore firestore;

  const FirestoreQuestionRep({
    required this.firestore,
  });

  @override
  Future<void> addQuestionCard(QuestionCard questionCard) async {
    final emptyDocument =
        await firestore.collection(questionCardCollection).add({});

    final questionCardWithId = QuestionCard(
        id: emptyDocument.id,
        question: questionCard.question,
        options: questionCard.options);
    emptyDocument.set(questionCardWithId.toMap());
  }

  @override
  FutureOr<void> deleteQuestionCard(QuestionCard questionCard) {
    // TODO: implement deleteQuestionCard
    throw UnimplementedError();
  }

  @override
  FutureOr<List<QuestionCard>> getAllQuestionCards() {
    // TODO: implement getAllQuestionCards
    throw UnimplementedError();
  }

  @override
  FutureOr<QuestionCard?> getPetById(String id) {
    // TODO: implement getPetById
    throw UnimplementedError();
  }

  @override
  FutureOr<void> updateQuestionCard(QuestionCard questionCard) {
    // TODO: implement updateQuestionCard
    throw UnimplementedError();
  }
}
