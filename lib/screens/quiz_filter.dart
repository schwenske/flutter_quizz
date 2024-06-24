import 'package:flutter/material.dart';
import 'package:flutter_quizz/screens/quizzen.dart';
import 'package:flutter_quizz/widgets/custom_button.dart';

class QuizFilter extends StatefulWidget {
  const QuizFilter({super.key});

  @override
  State<QuizFilter> createState() => _QuizFilterState();
}

class _QuizFilterState extends State<QuizFilter> {
  List<String> tags = ['imt101', 'imt102', 'ipwa01', 'ipwa02'];
  List<int> count = [3, 5, 10];
  late int? currentCount;
  String? currentTag;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              "Quizzen",
              style: Theme.of(context).textTheme.displaySmall,
            ),
          ),
          body: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(50),
                child: Column(
                  children: [
                    DropdownButtonFormField<String>(
                      hint: Text(
                        "Bitte wählen Sie einen Kurs aus:",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      items: [
                        for (int i = 0; i < tags.length; i++)
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
                      validator: (value) =>
                          value == null ? "Bitte Tag auswählen" : null,
                    ),
                    DropdownButtonFormField<int>(
                      hint: Text(
                        "Bitte wählen Sie die Anzahl der Fragen:",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      items: [
                        for (int i = 0; i < count.length; i++)
                          DropdownMenuItem(
                            value: count.elementAt(i),
                            child: Text(
                              count.elementAt(i).toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(color: Colors.brown),
                            ),
                          ),
                      ],
                      onChanged: (value) {
                        currentCount = value;
                      },
                      validator: (value) =>
                          value == null ? "Bitte Anzahl auswählen" : null,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: CustomButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute<Quizzen>(
                                    builder: (context) => Quizzen(
                                        tag: currentTag!,
                                        count: currentCount!)));
                          },
                          label: "Quizzen"),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
