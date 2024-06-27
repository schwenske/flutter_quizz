import 'package:flutter/material.dart';

class GameOverWidget extends StatefulWidget {
  final int points;
  const GameOverWidget({super.key, required this.points});

  @override
  State<GameOverWidget> createState() => _GameOverWidgetState();
}

class _GameOverWidgetState extends State<GameOverWidget> {
  @override
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Das Spiel ist zuende!'),
            Text('${widget.points}')
          ],
        ),
      ),
    );
  }
}
