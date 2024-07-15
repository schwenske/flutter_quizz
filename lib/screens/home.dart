import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quizz/screens/create_questions.dart';
import 'package:flutter_quizz/screens/my_questions.dart';
import 'package:flutter_quizz/screens/ranking.dart';
import 'package:flutter_quizz/screens/widgets/custom_button.dart';
import 'package:flutter_quizz/screens/widgets/quiz_filter.dart';

/// App title for display.
var titleName = "Quizz APP";

/// Spacing between buttons.
const double buttonSpacing = 15;

/// Home screen of the app, displaying main actions.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            titleName,
            style: Theme.of(context).textTheme.displaySmall,
          ),
          actions: [
            // Profile button
            IconButton(
              icon: const Icon(Icons.person),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<ProfileScreen>(
                    builder: (context) => ProfileScreen(
                      appBar: AppBar(
                        title: const Text('User Profile'),
                      ),
                      actions: [
                        SignedOutAction((context) {
                          Navigator.of(context).pop();
                        })
                      ],
                      children: const [
                        Divider(),
                        Padding(
                          padding: EdgeInsets.all(2),
                          child: AspectRatio(
                            aspectRatio: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(50),
              child: Column(
                children: [
                  // Main action buttons
                  Column(
                    children: [
                      CustomButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute<QuizFilter>(
                              builder: (context) => const QuizFilter(),
                            ),
                          );
                        },
                        label: "Quizzen",
                      ),
                      CustomButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute<MyQuestions>(
                              builder: (context) => const MyQuestions(),
                            ),
                          );
                        },
                        label: "Meine Fragen",
                      ),
                      CustomButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute<Ranking>(
                              builder: (context) => const Ranking(),
                            ),
                          );
                        },
                        label: "Rangliste",
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute<Ranking>(
                builder: (context) => const CreateQuestions(),
              ),
            );
          },
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.purple,
          child: Container(height: 30.0),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      ),
    );
  }
}
