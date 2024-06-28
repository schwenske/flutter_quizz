import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'home.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return SignInScreen(
            providers: [
              EmailAuthProvider(),
            ],
            headerBuilder: (context, constraints, shrinkOffset) {
              return SafeArea(
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        const Text(
                          'Quizzen',
                          style: TextStyle(fontSize: 24),
                        ),
                        const Text(''),
                        const Text(
                          'Achtung, verwenden Sie immer ein starkes Passwort!',
                          style: TextStyle(fontSize: 16),
                        ),
                        InkWell(
                          onTap: () async {
                            if (await canLaunchUrlString(
                                'https://www.datenschutz.org/passwort-generator/')) {
                              await launchUrlString(
                                  'https://www.datenschutz.org/passwort-generator/');
                            } else {
                              //
                            }
                          },
                          child: const Text(
                            'Passwort-Generator von datenschutz.org verwenden',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.blue, // Blau
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }

        return const HomeScreen();
      },
    );
  }
}
