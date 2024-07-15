import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'home.dart';

/// A widget that displays either the sign-in screen or the home screen based on the user's authentication state.
class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          // User is not authenticated, show sign-in screen
          return SignInScreen(
            providers: [
              EmailAuthProvider(),
            ],
            subtitleBuilder: (context, action) {
              return const Center(
                child: Column(
                  children: [
                    Text(
                      'Quizzen',
                      style: TextStyle(fontSize: 24),
                    ),
                    Text(''), // Empty space for spacing
                  ],
                ),
              );
            },
            footerBuilder: (context, action) {
              return Column(
                children: [
                  const Text(''), // Empty space for spacing
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
                        // Handle error if URL cannot be launched
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
              );
            },
          );
        }

        // User is authenticated, show home screen
        return const HomeScreen();
      },
    );
  }
}
