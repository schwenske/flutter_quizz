import 'package:flutter/material.dart';
import 'screens/auth_gate.dart';

/// The main application widget.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      /// Sets the overall theme for the app.
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),

      /// Defines the initial route of the app.
      home: const AuthGate(),
    );
  }
}
