import 'package:flutter/material.dart';
import 'package:flutter_quizz/data/model/question_card.dart';

class QuestionCardGame extends StatelessWidget {
  final QuestionCard questionCard;

  const QuestionCardGame({super.key, required this.questionCard});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(questionCard.toString()),
    );
  }
}
