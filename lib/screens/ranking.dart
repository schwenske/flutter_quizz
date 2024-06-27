import 'package:flutter/material.dart';

class Ranking extends StatelessWidget {
  const Ranking({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Ranking"),
          ),
        ),
      ),
    );
  }
}
