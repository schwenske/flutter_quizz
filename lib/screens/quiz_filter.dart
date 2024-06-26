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
                  Padding(
                    padding: const EdgeInsets.only(top: 150),
                    child: CustomButton(
                        onPressed: () {
                          if (currentTag != null && currentCount != null) {
                            try {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute<Quizzen>(
                                      builder: (context) => Quizzen(
                                          tag: currentTag!,
                                          count: currentCount!)));
                            } catch (e) {
                              print(e.toString());
                            }
                          } else {
                            print('fehler');
                          }
                        },
                        label: "Quizzen"),
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
