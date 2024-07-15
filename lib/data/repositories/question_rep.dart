import 'dart:async';
import 'package:flutter_quizz/data/model/question_card.dart';

/// Abstract class defining the contract for a question repository.
/// This class outlines the methods that any implementation of a question
/// repository must provide.
abstract class QuestionRep {
  /// Retrieves a question card by its ID.
  ///
  /// Returns a future that completes with the desired question card or null if not found.
  FutureOr<QuestionCard?> getQuestionCardById(String id);

  /// Retrieves a list of all question cards.
  ///
  /// Returns a future that completes with a list of all question cards.
  FutureOr<List<QuestionCard>> getAllQuestionCards();

  /// Adds a new question card to the repository.
  ///
  /// Returns a future that completes when the question card has been added.
  FutureOr<void> addQuestionCard(QuestionCard questionCard);

  /// Updates an existing question card in the repository.
  ///
  /// Returns a future that completes when the question card has been updated.
  FutureOr<void> updateQuestionCard(QuestionCard questionCard);

  /// Deletes a question card by its ID.
  ///
  /// Returns a future that completes when the question card has been deleted.
  FutureOr<void> deleteQuestionCardById(String questionCard);
}
