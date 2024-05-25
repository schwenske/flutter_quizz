import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quizz/screens/create_questions.dart';
import 'package:flutter_quizz/screens/my_questions.dart';
import 'package:flutter_quizz/screens/quizzen.dart';
import 'package:flutter_quizz/screens/ranking.dart';

var titleName = "Quizz APP";
const double buttonSpacing = 15;

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                    children: [
                      const Divider(),
                      Padding(
                        padding: const EdgeInsets.all(2),
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: Image.asset('flutterfire_300x.png'),
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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(50),
          child: Column(
            children: [
              Text(
                titleName,
                style: Theme.of(context).textTheme.displaySmall,
              ),
              Column(
                children: [
                  Padding(
                      padding: const EdgeInsets.all(buttonSpacing),
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute<Quizzen>(
                                    builder: (context) => const Quizzen()));
                          },
                          child: const Text("Quizzen"))),
                  Padding(
                      padding: const EdgeInsets.all(buttonSpacing),
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute<MyQuestions>(
                                    builder: (context) => const MyQuestions()));
                          },
                          child: const Text("MyQuestions"))),
                  Padding(
                      padding: const EdgeInsets.all(buttonSpacing),
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute<Ranking>(
                                    builder: (context) => const Ranking()));
                          },
                          child: const Text("Ranking"))),
                  const Padding(
                      padding: EdgeInsets.all(buttonSpacing),
                      child: SignOutButton()),
                ],
              )
            ],
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
    );
  }
}
