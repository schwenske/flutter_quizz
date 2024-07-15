import 'package:flutter/material.dart';
import 'package:flutter_quizz/data/model/question_card.dart';
import 'package:flutter_quizz/screens/widgets/game_over_widget.dart';
import 'package:flutter_quizz/screens/widgets/question_card_game.dart';

// Global variable to count points
int countPoints = 0;

// StatefulWidget for displaying a single loaded question card
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

// State class for the QuestionCardSingleLoaded widget
class _QuestionCardSingleLoadedState extends State<QuestionCardSingleLoaded> {
  int index = 0; // Current index of the question card
  bool isVisible = true; // Visibility of the floating action button
  bool isFloatBlocked = true; // State to block the floating action button
  int sumOfPoints = 0; // Sum of points

  @override
  void initState() {
    // Initialization when the widget is first created
    resetAll(index, widget.questionCards.length);
    updateIsFloatBlocked(true);
    super.initState();
  }

  // Function to update the state of isFloatBlocked
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
              // Back button pressed: reset points, clear question cards, and navigate back
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
                  // If the index is within the list of question cards, show the current question card
                  if (index < widget.questionCards.length)
                    QuestionCardGame(
                      questionCard: widget.questionCards[index],
                      isFloatBlocked: true,
                      callBoolBack: updateIsFloatBlocked,
                    ),
                  // If all questions are answered, show the GameOver widget
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
          absorbing:
              isFloatBlocked, // Disable the button if isFloatBlocked is true
          child: Visibility(
            visible: isVisible, // Control the visibility of the button
            child: FloatingActionButton(
              child: const Icon(Icons.arrow_right),
              onPressed: () {
                setState(() {
                  // Increment the index and reset states
                  index++;
                  resetAll(index, widget.questionCards.length);

                  // Hide the button if all questions are answered
                  if (index >= widget.questionCards.length) {
                    isVisible = false;
                  }
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

// Function to reset all necessary states for a new question
void resetAll(
  int forIndex,
  int intQuestionCards,
) {
  isBlocked = false;

  gameCardCurrentBool = [false, false, false, false];
  gameCardColor = [Colors.white, Colors.white, Colors.white, Colors.white];
  correctAnswer = [false, false, false, false];
  answerList = [];
}
