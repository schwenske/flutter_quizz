import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
        tag: questionCard.tag,
        author: questionCard.author,
        question: questionCard.question,
        options: questionCard.options,
        reason: questionCard.reason);
    emptyDocument.set(questionCardWithId.toMap());
  }

  Stream<List<QuestionCard>> getQuestionCardStream() {
    return firestore.collection(questionCardCollection).snapshots().map(
          (snapshot) => snapshot.docs
              .map((doc) => QuestionCard.fromMap(doc.data()))
              .toList(),
        );
  }

  @override
  Future<List<QuestionCard>> getAllQuestionCards() async {
    final questionCardSnapshots =
        await firestore.collection(questionCardCollection).get();

    final questionCardList = questionCardSnapshots.docs
        .map((snapshot) => QuestionCard.fromMap(snapshot.data()))
        .toList();

    return questionCardList;
  }

  @override
  Future<QuestionCard?> getQuestionCardById(String questionCardId) async {
    final document = await firestore
        .collection(questionCardCollection)
        .doc(questionCardId)
        .get();

    if (document.data() != null) {
      return QuestionCard.fromMap(document.data()!);
    }

    return null;
  }

  @override
  Future<void> updateQuestionCard(
    QuestionCard questionCard, {
    @visibleForTesting String? testDocId,
  }) async {
    await firestore
        .collection(questionCardCollection)
        .doc(testDocId ?? questionCard.id)
        .update(questionCard.toMap());
  }

  @override
  Future<void> deleteQuestionCardById(String questionCardId) async {
    await firestore
        .collection(questionCardCollection)
        .doc(questionCardId)
        .delete();
  }

  Future<List<QuestionCard>> getQuestionCardByTag(Tag tag) async {
    final questionCardSnapshot = await firestore
        .collection(questionCardCollection)
        .where("Tag", isEqualTo: tag.index)
        .get();

    final questionCardList = questionCardSnapshot.docs
        .map(
          (doc) => QuestionCard.fromMap(doc.data()),
        )
        .toList();

    return questionCardList;
  }

  Future<QuestionCard?> getQuestionCardByUserId(
      String questionCardUserId) async {
    final document = await firestore
        .collection(questionCardCollection)
        .doc(questionCardUserId)
        .get();

    if (document.data() != null) {
      return QuestionCard.fromMap(document.data()!);
    }

    return null;
  }
}
