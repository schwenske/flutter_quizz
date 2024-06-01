import "package:flutter/material.dart";

class QuestionCardListLoading extends StatelessWidget {
  const QuestionCardListLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
