// main.dart
import 'package:flutter/material.dart';
import 'screens/login_screen.dart';

void main() => runApp(const LoginApp());

class LoginApp extends StatelessWidget {
  const LoginApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue).copyWith(
          primary: Colors.blue, // AppBar e botão Login
          onPrimary: Colors.white,
        ),
      ),
      home: const LoginScreen(),
    );
  }
}