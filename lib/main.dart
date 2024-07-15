import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quizz/firebase_options.dart';
import 'package:flutter_quizz/my_app.dart';

/// The main entry point for the application.
/// Initializes Firebase and runs the Flutter app.
void main() async {
  /// Ensures that the Flutter binding is initialized before accessing platform-specific features.
  WidgetsFlutterBinding.ensureInitialized();

  /// Initializes Firebase with the provided options.
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  /// Runs the Flutter app.
  runApp(const MyApp());
}
