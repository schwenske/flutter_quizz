import 'package:flutter/material.dart';

class QuizFilter extends StatefulWidget {
  const QuizFilter({super.key});

  @override
  State<QuizFilter> createState() => _QuizFilterState();
}

class _QuizFilterState extends State<QuizFilter> {
  List<String> tags = ['imt101', 'imt102', 'ipwa01', 'ipwa02'];
  List<int> count = [3, 5, 10];
  late int currentCount;
  String? currentTag;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text('Quiz auswahl'),
      ),
      body: Column(
        children: [
          DropdownButtonFormField<String>(
            hint: Text(
              "Bitte wählen Sie einen Kurs aus:",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            items: [
              for (int i = 0; i <= 3; i++)
                DropdownMenuItem(
                  value: tags.elementAt(i),
                  child: Text(
                    tags.elementAt(i),
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: Colors.brown),
                  ),
                ),
            ],
            onChanged: (value) {
              currentTag = value.toString();
            },
            validator: (value) => value == null ? "Bitte Tag auswählen" : null,
          ),
          DropdownButtonFormField<int>(
            hint: Text(
              "Bitte wählen Sie einen Kurs aus:",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            items: [
              for (int i = 0; i <= 3; i++)
                DropdownMenuItem(
                  value: count.elementAt(i),
                  child: Text(
                    count.elementAt(i) as String,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: Colors.brown),
                  ),
                ),
            ],
            onChanged: (value) {
              currentCount = String.parse(value);
            },
            validator: (value) => value == null ? "Bitte Tag auswählen" : null,
          ),
        ],
      ),
    ));
  }
}
