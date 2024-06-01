import "package:flutter/material.dart";

class QuestionCardListError extends StatelessWidget {
  final String message;

  const QuestionCardListError({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        message,
        style:
            Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.blue),
      ),
    );
  }
}
