import 'package:flutter/material.dart';

/// A widget to display an error message within a list.
class ListError extends StatelessWidget {
  /// The error message to be displayed.
  final String message;

  const ListError({
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
