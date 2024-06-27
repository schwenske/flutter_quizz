import 'package:flutter/material.dart';
import 'package:flutter_quizz/data/model/question_card.dart';
import 'package:flutter_quizz/widgets/game_over_widget.dart';
import 'package:flutter_quizz/widgets/question_card_game.dart';

int countPoints = 0;

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
  bool isVisible = true;
  bool isFloatBlocked = true;
  int sumOfPoints = 0;

  @override
  void initState() {
    resetAll(index, widget.questionCards.length, isVisible);
    updateIsFloatBlocked(true);
    super.initState();
  }

  void updateIsFloatBlocked(bool newIsFloatBlocked) {
    setState(() {
      isFloatBlocked = newIsFloatBlocked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              countPoints = 0;
              widget.questionCards.clear();
              Navigator.pop(context);
            },
          ),
          centerTitle: true,
          title: Text(
            "Quizzen",
            style: Theme.of(context).textTheme.displaySmall,
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Center(
              child: Column(
                children: [
                  if (index < widget.questionCards.length)
                    QuestionCardGame(
                      questionCard: widget.questionCards[index],
                      isFloatBlocked: true,
                      callBoolBack: updateIsFloatBlocked,
                    ),
                  if (index >= widget.questionCards.length)
                    GameOverWidget(
                      points: countPoints,
                    ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: AbsorbPointer(
          absorbing: isFloatBlocked,
          child: Visibility(
            visible: isVisible,
            child: FloatingActionButton(
              child: const Icon(Icons.arrow_right),
              onPressed: () {
                setState(() {
                  index++;
                  resetAll(index, widget.questionCards.length, isVisible);
                  /*
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
                  if (index >= widget.questionCards.length) {
                    isVisible = false;
                  }*/
                  updateIsFloatBlocked(true);
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}

void resetAll(
  int forIndex,
  int intQuestionCards,
  bool forIsVisible,
) {
  isBlocked = false;

  gameCardCurrentBool = [false, false, false, false];
  gameCardColor = [Colors.white, Colors.white, Colors.white, Colors.white];
  correctAnswer = [false, false, false, false];
  answerList = [];
  if (forIndex >= intQuestionCards) {
    forIsVisible = false;
  }
}
