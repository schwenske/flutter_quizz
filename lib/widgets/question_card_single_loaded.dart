import 'package:flutter/material.dart';
import 'package:flutter_quizz/data/model/question_card.dart';
import 'package:flutter_quizz/widgets/question_card_game.dart';

class QuestionCardSingleLoaded extends StatelessWidget {
  final List<QuestionCard> questionCards;

  const QuestionCardSingleLoaded({
    super.key,
    required this.questionCards,
  });

  @override
  Widget build(BuildContext context) {
    return QuestionCardGame(questionCard: questionCards[0]);
  }
}
