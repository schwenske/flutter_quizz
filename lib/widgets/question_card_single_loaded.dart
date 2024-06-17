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
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quizzen'),
      ),
      body: QuestionCardGame(questionCard: widget.questionCards[index]),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.arrow_right),
        onPressed: () {
          setState(() {
            index++;
            isBlocked = false;

            gameCardCurrentBool = [false, false, false, false];
            gameCardColor = [
              Colors.white,
              Colors.white,
              Colors.white,
              Colors.white
            ];
            correctAnswer = [false, false, false, false];
            answerList = [];
          });
        },
      ),
    );
  }
}
