import 'package:flutter/material.dart';
import 'package:flutter_quizz/data/model/question_card.dart';
import 'package:flutter_quizz/widgets/question_card_game.dart';

class QuestionCardSingleLoaded extends StatefulWidget {
  final List<QuestionCard> questionCards;

  const QuestionCardSingleLoaded({
    super.key,
    required this.questionCards,
  });

  @override
  State<QuestionCardSingleLoaded> createState() =>
      _QuestionCardSingleLoadedState();
}

class _QuestionCardSingleLoadedState extends State<QuestionCardSingleLoaded> {
  @override
  Widget build(BuildContext context) {
    return QuestionCardGame(questionCard: widget.questionCards[0]);
  }
}
