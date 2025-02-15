import 'package:flutter/material.dart';
import 'package:flutter_quizz/data/repositories/tag_rep.dart';
import 'package:flutter_quizz/screens/quizzen.dart';
import 'package:flutter_quizz/screens/widgets/custom_button.dart';

/// Screen for filtering quizzes based on tag and question count.
class QuizFilter extends StatefulWidget {
  const QuizFilter({super.key});

  @override
  State<QuizFilter> createState() => _QuizFilterState();
}

class _QuizFilterState extends State<QuizFilter> {
  final _formKey = GlobalKey<FormState>();

  /// List of available tags for filtering quizzes.
  List<String> tags = tagRep;

  /// Possible question counts for filtering quizzes.
  List<int> count = [3, 5, 10];

  /// Selected question count.
  late int? currentCount;

  /// Selected tag for filtering quizzes.
  String? currentTag;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Quizzen",
            style: Theme.of(context).textTheme.displaySmall,
          ),
        ),
        body: Container(
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        // Dropdown for selecting the quiz tag
                        DropdownButtonFormField<String>(
                          hint: Text(
                            overflow: TextOverflow.ellipsis,
                            "Bitte wählen Sie einen Kurs aus:",
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          items: [
                            for (int i = 0; i < tags.length; i++)
                              DropdownMenuItem(
                                value: tags.elementAt(i),
                                child: Text(
                                  overflow: TextOverflow.clip,
                                  tags.elementAt(i),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(color: Colors.black),
                                ),
                              ),
                          ],
                          isExpanded: true,
                          onChanged: (value) {
                            currentTag = value.toString();
                          },
                          validator: (value) =>
                              value == null ? "Bitte Tag auswählen" : null,
                        ),
                        // Dropdown for selecting the question count
                        DropdownButtonFormField<int>(
                          hint: Text(
                            overflow: TextOverflow.ellipsis,
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
                                      .copyWith(color: Colors.black),
                                ),
                              ),
                          ],
                          onChanged: (value) {
                            currentCount = value;
                          },
                          validator: (value) =>
                              value == null ? "Bitte Anzahl auswählen" : null,
                        ),
                        // Button to start the quiz
                        Padding(
                          padding: const EdgeInsets.only(top: 150),
                          child: CustomButton(
                            onPressed: () {
                              if (_formKey.currentState?.validate() ?? false) {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute<Quizzen>(
                                    builder: (context) => Quizzen(
                                      tag: currentTag!,
                                      count: currentCount!,
                                    ),
                                  ),
                                );
                              }
                            },
                            label: "Quizzen",
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
