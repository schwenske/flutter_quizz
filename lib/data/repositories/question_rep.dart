import 'dart:async';
import 'package:flutter_quizz/data/model/question_card.dart';

abstract class QuestionRep {
  FutureOr<QuestionCard?> getPetById(String id);
  FutureOr<List<QuestionCard>> getAllQuestionCards();
  FutureOr<void> addQuestionCard(QuestionCard questionCard);
  FutureOr<void> updateQuestionCard(QuestionCard questionCard);
  FutureOr<void> deleteQuestionCard(QuestionCard questionCard);
}
