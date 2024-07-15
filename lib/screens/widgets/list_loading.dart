import 'package:flutter/material.dart';

/// A widget to display a loading indicator while data is being fetched.
class ListLoading extends StatelessWidget {
  const ListLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
