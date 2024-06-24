import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quizz/screens/create_questions.dart';
import 'package:flutter_quizz/screens/my_questions.dart';
import 'package:flutter_quizz/screens/quiz_filter.dart';
import 'package:flutter_quizz/screens/ranking.dart';
import 'package:flutter_quizz/widgets/custom_Button.dart';

var titleName = "Quizz APP";
const double buttonSpacing = 15;

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              titleName,
              style: Theme.of(context).textTheme.displaySmall,
            ),
            actions: [
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
              )
            ],
            automaticallyImplyLeading: false,
          ),
          body: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(50),
                child: Column(
                  children: [
                    Column(
                      children: [
                        CustomButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute<QuizFilter>(
                                      builder: (context) =>
                                          const QuizFilter()));
                            },
                            label: "Quizzen"),
                        CustomButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute<MyQuestions>(
                                      builder: (context) =>
                                          const MyQuestions()));
                            },
                            label: "MyQuestions"),
                        CustomButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute<Ranking>(
                                      builder: (context) => const Ranking()));
                            },
                            label: "Ranking"),
                      ],
                    )
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
                        builder: (context) => const CreateQuestions()));
              }),
          bottomNavigationBar: BottomAppBar(
            color: Colors.purple,
            child: Container(height: 30.0),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        ),
      ),
    );
  }
}
