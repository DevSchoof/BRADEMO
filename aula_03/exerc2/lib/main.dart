// Exercício 2 - Um novo ThemeData (aninhado) que sobrescreve o inicial
// e usa amarelo como cor de background.
// Rodar com: flutter run -t lib/exercicios/ex2.dart
import 'package:flutter/material.dart';

void main() => runApp(const Ex2App());

class Ex2App extends StatelessWidget {
  const Ex2App({super.key});

  @override
  Widget build(BuildContext context) {
    // Tema inicial (azul), definido no MaterialApp.
    final temaAzul = ThemeData(
      scaffoldBackgroundColor: Colors.blue,
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.blue,
      ).copyWith(surface: Colors.blue),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: temaAzul,
      home: Scaffold(
        body: Row(
          children: [
            // Widget da esquerda: usa o tema do MaterialApp (azul).
            const Expanded(child: ThemeBox(label: 'ThemeData inicial (azul)')),

            // Widget da direita: envolvido por um Theme que SOBRESCREVE
            // o tema herdado, trocando o background para amarelo.
            Expanded(
              child: Theme(
                data: temaAzul.copyWith(
                  scaffoldBackgroundColor: Colors.yellow,
                  colorScheme:
                      temaAzul.colorScheme.copyWith(surface: Colors.yellow),
                ),
                child: const ThemeBox(label: 'ThemeData sobrescrito (amarelo)'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Pinta o fundo com a cor "surface" do tema mais próximo na árvore.
class ThemeBox extends StatelessWidget {
  final String label;
  const ThemeBox({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    final cores = Theme.of(context).colorScheme;
    return Container(
      color: cores.surface,
      alignment: Alignment.center,
      padding: const EdgeInsets.all(16),
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.black, fontSize: 18),
      ),
    );
  }
}