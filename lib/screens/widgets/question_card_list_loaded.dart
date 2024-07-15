import 'package:flutter/material.dart';
import 'package:flutter_quizz/data/model/question_card.dart';

/// Displays a list of question cards with their details.
class QuestionCardListLoaded extends StatelessWidget {
  /// The list of question cards to be displayed.
  final List<QuestionCard> questionCards;

  const QuestionCardListLoaded({
    super.key,
    required this.questionCards,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: questionCards.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(
            '${questionCards[index].question}\n',
            style: Theme.of(context).textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
          tileColor: Colors.white54,
          subtitle: Column(
            children: [
              for (int i = 0; i < questionCards[index].options.length; i++)
                if (questionCards[index].options.values.elementAt(i) == true)
                  Container(
                    color: Colors.green[200],
                    child: Text(
                      questionCards[index].options.keys.elementAt(i),
                      style: const TextStyle(fontSize: 16),
                    ),
                  )
                else
                  Container(
                    color: Colors.red[200],
                    child: Text(
                      questionCards[index].options.keys.elementAt(i),
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
              Text(
                '\n${questionCards[index].reason}',
                style: const TextStyle(fontSize: 24),
              ),
            ],
          ),
        );
      },
      separatorBuilder: (context, index) => const Divider(
        color: Colors.black,
      ),
    );
  }
}
