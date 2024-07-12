import 'package:flutter/material.dart';
import 'package:flutter_quizz/data/model/question_card.dart';
import 'package:flutter_quizz/screens/widgets/question_card_list_loaded.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late List<QuestionCard> tQuestionCards;

  setUp(() {
    tQuestionCards = [
      QuestionCard(
          id: 't1',
          tag: 'ipwa01 - Programmierung von Web...',
          author: '1t5Ps2YcqobhfDCxxA5DsPnXEjl1',
          question: 'testfrage1',
          options: {
            'antwort1': true,
            'antwort2': false,
            'antwort3': false,
            'antwort4': false
          },
          reason: 'die Antwort 1'),
      QuestionCard(
          id: 't2',
          tag: 'ipwa01 - Programmierung von Web...',
          author: '1t5Ps2YcqobhfDCxxA5DsPnXEjl1',
          question: 'testfrage2',
          options: {
            'antwort1': false,
            'antwort2': true,
            'antwort3': false,
            'antwort4': false
          },
          reason: 'die Antwort 1'),
    ];
  });

  testWidgets('should display all given Questioncards', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: QuestionCardListLoaded(questionCards: tQuestionCards),
        ),
      ),
    );
    expect(find.byType(ListView), findsWidgets);
    await expectLater(
      find.byType(MaterialApp),
      matchesGoldenFile("question_list_loaded.png"),
    );
  });
}
