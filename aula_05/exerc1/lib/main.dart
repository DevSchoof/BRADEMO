import 'package:flutter/material.dart';

// Atividade 1 - Prática usando async e await
// (solução oficial: https://dart.dev/codelabs/async-await)

// ---------- Funções fornecidas pelo exercício (simulam operações lentas) ----------
const _meioSegundo = Duration(milliseconds: 500);

Future<String> fetchRole() => Future.delayed(_meioSegundo, () => 'administrator');

Future<int> fetchLoginAmount() => Future.delayed(_meioSegundo, () => 42);

// ---------- Parte 1: reportUserRole ----------
Future<String> reportUserRole() async {
  final username = await fetchRole();
  return 'User role: $username';
}

// ---------- Parte 2: reportLogins ----------
Future<String> reportLogins() async {
  final logins = await fetchLoginAmount();
  return 'Total number of logins: $logins';
}

// ---------- Interface: mostra o resultado na tela ----------
void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Atividade 1',
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
  String? _role;
  String? _logins;

  @override
  void initState() {
    super.initState();
    _carregar(); // executado uma única vez
  }

  Future<void> _carregar() async {
    final role = await reportUserRole();
    final logins = await reportLogins();
    if (!mounted) return;
    setState(() {
      _role = role;
      _logins = logins;
    });
    debugPrint(role); // User role: administrator
    debugPrint(logins); // Total number of logins: 42
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Atividade 1 - async/await')),
      body: Center(
        child: _role == null
            ? const CircularProgressIndicator()
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(_role!, style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 12),
                  Text(_logins!, style: Theme.of(context).textTheme.titleLarge),
                ],
              ),
      ),
    );
  }
}