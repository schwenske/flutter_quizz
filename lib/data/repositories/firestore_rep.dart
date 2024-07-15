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

/// Constants for Firestore collection names
const questionCardCollection = "questionCards";
const userRankingCollection = "userRankings";

/// Initialize Firebase Authentication
FirebaseAuth auth = FirebaseAuth.instance;

/// Get the current user's ID
String userId = auth.currentUser!.uid;

/// Repository class for interacting with Firestore for questions and rankings
class FirestoreRep implements QuestionRep, RankingRep {
  /// Reference to Firestore database
  final FirebaseFirestore firestore;

  /// Constructor for FirestoreRep
  const FirestoreRep({
    required this.firestore,
  });

  /// Adds a new question card to the Firestore database
  @override
  Future<void> addQuestionCard(QuestionCard questionCard) async {
    // Create an empty document to generate a new ID
    final emptyDocument =
        await firestore.collection(questionCardCollection).add({});

    // Create a new QuestionCard with the generated ID
    final questionCardWithId = QuestionCard(
      id: emptyDocument.id,
      tag: questionCard.tag,
      author: questionCard.author,
      question: questionCard.question,
      options: questionCard.options,
      reason: questionCard.reason,
    );

    // Set the data for the newly created document
    emptyDocument.set(questionCardWithId.toMap());
  }

  /// Returns a Stream of QuestionCard lists, updating whenever the database changes
  Stream<List<QuestionCard>> getQuestionCardStream() {
    return firestore.collection(questionCardCollection).snapshots().map(
          (snapshot) => snapshot.docs
              .map((doc) => QuestionCard.fromMap(doc.data()))
              .toList(),
        );
  }

  /// Retrieves all question cards from the Firestore database
  @override
  Future<List<QuestionCard>> getAllQuestionCards() async {
    final questionCardSnapshots =
        await firestore.collection(questionCardCollection).get();
    return questionCardSnapshots.docs
        .map((snapshot) => QuestionCard.fromMap(snapshot.data()))
        .toList();
  }

  /// Retrieves a specific question card by its ID
  @override
  Future<QuestionCard?> getQuestionCardById(String questionCardId) async {
    final document = await firestore
        .collection(questionCardCollection)
        .doc(questionCardId)
        .get();
    return document.data() != null
        ? QuestionCard.fromMap(document.data()!)
        : null;
  }

  /// Updates an existing question card in the Firestore database
  @override
  Future<void> updateQuestionCard(QuestionCard questionCard,
      {@visibleForTesting String? testDocId}) async {
    await firestore
        .collection(questionCardCollection)
        .doc(testDocId ?? questionCard.id)
        .update(questionCard.toMap());
  }

  /// Deletes a question card by its ID
  @override
  Future<void> deleteQuestionCardById(String questionCardId) async {
    await firestore
        .collection(questionCardCollection)
        .doc(questionCardId)
        .delete();
  }

  /// Retrieves question cards by tag
  Future<List<QuestionCard>> getQuestionCardByTag(String tag) async {
    final questionCardSnapshot = await firestore
        .collection(questionCardCollection)
        .where("tag", isEqualTo: tag)
        .get();
    return questionCardSnapshot.docs
        .map((doc) => QuestionCard.fromMap(doc.data()))
        .toList();
  }

  /// Retrieves question cards by user ID (author)
  Future<List<QuestionCard>> getQuestionCardByUserId(String userId) async {
    final questionCardSnapshot = await firestore
        .collection(questionCardCollection)
        .where("author", isEqualTo: userId)
        .get();
    return questionCardSnapshot.docs
        .map((doc) => QuestionCard.fromMap(doc.data()))
        .toList();
  }

  /// Retrieves a random number of question cards by tag
  Future<List<QuestionCard>> getQuestionCardByTagAndCount(
      String tag, int count) async {
    final questionCardSnapshot = await firestore
        .collection(questionCardCollection)
        .where("tag", isEqualTo: tag)
        .get();

    // Shuffle the list of question cards
    final questionCardList = questionCardSnapshot.docs
        .map((doc) => QuestionCard.fromMap(doc.data()))
        .toList();
    questionCardList.shuffle(Random());

    // Return the first `count` elements from the shuffled list
    return questionCardList.sublist(0, min(count, questionCardList.length));
  }

  /// Adds a user ranking to the Firestore database
  @override
  Future<void> addUserRanking(UserRanking userRanking) async {
    final documentId = userId;
    final docRef = firestore.collection('userRankings').doc(documentId);
    final userRankingData = UserRanking(
        id: userRanking.id,
        counter: userRanking.counter,
        username: userRanking.username);
    docRef.set(userRankingData.toMap());
  }

  /// Retrieves the user ranking counter by ID
  Future<int> getUserRankingCounterById(String userRankingId) async {
    final document = await firestore
        .collection(userRankingCollection)
        .doc(userRankingId)
        .get();
    return document.data() != null
        ? UserRanking.fromMap(document.data()!).counter
        : -1;
  }

  /// Updates the counter value for a user ranking
  Future<void> updateCounter(String documentId, int newCounterValue) async {
    final docRef = firestore.collection('userRankings').doc(documentId);
    await docRef.update({'counter': newCounterValue});
  }

  /// Retrieves all user rankings sorted by counter descending
  Future<List<UserRanking>> getAllUserRankings() async {
    final userRankingSnapshots = await firestore
        .collection(userRankingCollection)
        .orderBy('counter', descending: true)
        .get();
    return userRankingSnapshots.docs
        .map((snapshot) => UserRanking.fromMap(snapshot.data()))
        .toList();
  }
}
