import 'package:flutter/material.dart';

/// A custom button with a defined appearance and behavior.
class CustomButton extends StatelessWidget {
  /// The callback function to be executed when the button is pressed.
  final Function onPressed;

  /// The label text displayed on the button.
  final String label;

  const CustomButton({super.key, required this.onPressed, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: GestureDetector(
        onTap: () => onPressed(),
        child: Container(
          /// Adjusts the button width based on screen size.
          width: MediaQuery.of(context).size.width > 600 ? 300 : 160,
          height: 40,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
            color: Colors.purple,
          ),
          child: Center(
            child: Text(
              label,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
