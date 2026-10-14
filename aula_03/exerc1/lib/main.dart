import 'package:flutter/material.dart';

void main() => runApp(const Ex1App());

class Ex1App extends StatelessWidget {
  const Ex1App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // Fundo das telas (Scaffold) em azul.
        scaffoldBackgroundColor: Colors.blue,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
        ).copyWith(surface: Colors.blue),
      ),
      home: const Scaffold(),
    );
  }
}