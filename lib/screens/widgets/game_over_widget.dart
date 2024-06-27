import 'package:flutter/material.dart';
import 'package:flutter_quizz/screens/home.dart';
import 'package:flutter_quizz/screens/widgets/custom_button.dart';
import 'package:flutter_quizz/screens/widgets/question_card_single_loaded.dart';

class GameOverWidget extends StatefulWidget {
  final int points;
  const GameOverWidget({super.key, required this.points});

  @override
  State<GameOverWidget> createState() => _GameOverWidgetState();
}

class _GameOverWidgetState extends State<GameOverWidget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: Text(
                'Das Spiel ist zuende!',
                style: DefaultTextStyle.of(context)
                    .style
                    .apply(fontSizeFactor: 1.7),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Text(
                'Sie haben ${widget.points} Punkte erzielt.',
                style: DefaultTextStyle.of(context)
                    .style
                    .apply(fontSizeFactor: 1.7),
              ),
            ),
            CustomButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute<HomeScreen>(
                        builder: (context) => const HomeScreen()));
                resetAll(0, 1, false);
                countPoints = 0;
              },
              label: 'Home',
            ),
          ],
        ),
      ),
    );
  }
}
