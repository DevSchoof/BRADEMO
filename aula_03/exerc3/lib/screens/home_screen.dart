// screens/home_screen.dart
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cores = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: cores.primary,
        foregroundColor: cores.onPrimary,
        title: const Text('Flutter By Example'),
      ),
      // Só o símbolo do Flutter, sem texto.
      body: const Center(
        child: FlutterLogo(size: 280),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        shape: const CircleBorder(), // redondo
        backgroundColor: cores.primary, // mesmo fundo da AppBar
        foregroundColor: Colors.white, // estrela branca
        child: const Icon(Icons.star),
      ),
    );
  }
}
