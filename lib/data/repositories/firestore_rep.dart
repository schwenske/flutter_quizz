import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quizz/data/model/question_card.dart';
import 'package:flutter_quizz/data/model/user_ranking.dart';
import 'package:flutter_quizz/data/repositories/question_rep.dart';
import 'package:flutter_quizz/data/repositories/ranking_rep.dart';

const questionCardCollection = "questionCards";
const userRankingCollection = "userRankings";

FirebaseAuth auth = FirebaseAuth.instance;
String userId = auth.currentUser!.uid;

class FirestoreRep implements QuestionRep, RankingRep {
  final FirebaseFirestore firestore;

  const FirestoreRep({
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
      reason: questionCard.reason,
    );
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

  Future<List<QuestionCard>> getQuestionCardByTag(String tag) async {
    final questionCardSnapshot = await firestore
        .collection(questionCardCollection)
        .where("tag", isEqualTo: tag)
        .get();

    final questionCardList = questionCardSnapshot.docs
        .map(
          (doc) => QuestionCard.fromMap(doc.data()),
        )
        .toList();

    return questionCardList;
  }

  Future<List<QuestionCard>> getQuestionCardByUserId(String userId) async {
    final questionCardSnapshot = await firestore
        .collection(questionCardCollection)
        .where("author", isEqualTo: userId)
        .get();

    final questionCardList = questionCardSnapshot.docs
        .map(
          (doc) => QuestionCard.fromMap(doc.data()),
        )
        .toList();

    return questionCardList;
  }

  Future<List<QuestionCard>> getQuestionCardByTagAndCount(
      String tag, int count) async {
    final questionCardSnapshot = await firestore
        .collection(questionCardCollection)
        .where("tag", isEqualTo: tag)
        .get();

    Random random = Random();

    final questionCardList = questionCardSnapshot.docs
        .map(
          (doc) => QuestionCard.fromMap(doc.data()),
        )
        .toList();
    questionCardList.shuffle(random);
    final List<QuestionCard> randomQuestionCardList = [];

    for (int i = 0; i < count; i++) {
      randomQuestionCardList.add(questionCardList[i]);
    }
    return randomQuestionCardList;
  }

  @override
  Future<void> addUserRanking(UserRanking userRanking) async {
    final String documentId = userId;
    final docRef = firestore.collection('userRankings').doc(documentId);

    final userRankingData = UserRanking(
        id: userRanking.id,
        counter: userRanking.counter,
        username: userRanking.username);
    docRef.set(userRankingData.toMap()).then((_) {});
  }

  Future<int> getUserRankingCounterById(String userRankingId) async {
    final document = await firestore
        .collection(userRankingCollection)
        .doc(userRankingId)
        .get();

    if (document.data() != null) {
      return UserRanking.fromMap(document.data()!).counter;
    }
    return -1;
  }

  Future<void> updateCounter(String documentId, int newCounterValue) async {
    final docRef = firestore.collection('userRankings').doc(documentId);

    await docRef.update({
      'counter': newCounterValue,
    });
  }

  Future<List<UserRanking>> getAllUserRankings() async {
    final userRankingSnapshots =
        await firestore.collection(userRankingCollection).get();

    final userRankingList = userRankingSnapshots.docs
        .map((snapshot) => UserRanking.fromMap(snapshot.data()))
        .toList();

    return userRankingList;
  }
}
