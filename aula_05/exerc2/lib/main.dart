import 'package:flutter/material.dart';

// Atividade 2 - Tratamento de erros em operações assíncronas
// (solução oficial: https://dart.dev/codelabs/async-await)

// ---------- Função fornecida pelo exercício ----------
// Simula uma operação assíncrona que demora e pode lançar uma exceção.
Future<String> fetchNewUsername() =>
    Future.delayed(const Duration(milliseconds: 500), () => throw UserError());

class UserError implements Exception {
  @override
  String toString() => 'New username is invalid';
}

// ---------- changeUsername ----------
// Retorna a string de fetchNewUsername() ou, se falhar,
// o valor em string do erro.
Future<String> changeUsername() async {
  try {
    return await fetchNewUsername();
  } catch (err) {
    return err.toString();
  }
}

// ---------- Interface: mostra o resultado na tela ----------
void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Atividade 2',
        theme: ThemeData(colorSchemeSeed: Colors.green, useMaterial3: true),
        home: const HomePage(),
      );
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? _resultado;

  @override
  void initState() {
    super.initState();
    _carregar(); // executado uma única vez
  }

  Future<void> _carregar() async {
    final resultado = await changeUsername();
    if (!mounted) return;
    setState(() => _resultado = resultado);
    debugPrint(resultado); // New username is invalid
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Atividade 2 - tratamento de erros')),
      body: Center(
        child: _resultado == null
            ? const CircularProgressIndicator()
            : Text(_resultado!, style: Theme.of(context).textTheme.titleLarge),
      ),
    );
  }
}