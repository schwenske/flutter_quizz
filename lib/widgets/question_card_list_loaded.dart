import "package:flutter/material.dart";
import "package:flutter_quizz/data/model/question_card.dart";

class QuestionCardListLoaded extends StatelessWidget {
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
            questionCards[index].question,
            style: Theme.of(context).textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
          tileColor: Colors.purple[50],
          subtitle: Column(
            children: [
              for (int i = 0; i < questionCards[index].options.length; i++)
                if (questionCards[index].options.values.elementAt(i) == true)
                  Text(questionCards[index].options.keys.elementAt(i),
                      style: TextStyle(color: Colors.green[800]))
                else
                  Text(
                    questionCards[index].options.keys.elementAt(i),
                    style: TextStyle(color: Colors.red[800]),
                  ),
              Text(questionCards[index].reason),
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
