// widgets/login_form.dart
import 'package:flutter/material.dart';
import '../models/login.dart';
import '../screens/home_screen.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _userController = TextEditingController();
  final _passController = TextEditingController();

  @override
  void dispose() {
    _userController.dispose();
    _passController.dispose();
    super.dispose();
  }

  void _entrar() {
    final login = Login(
      username: _userController.text.trim(),
      password: _passController.text,
    );

    if (login.isValid) {
      // Sucesso: vai para a nova página (sem botão de voltar ao login).
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } else {
      // Falha: mostra mensagem via SnackBar.
      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(
            content: Text('Falha no login: usuário ou senha inválidos'),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(
          controller: _userController,
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(
            labelText: 'Email',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _passController,
          obscureText: true,
          decoration: const InputDecoration(
            labelText: 'Password',
            border: OutlineInputBorder(),
          ),
          onSubmitted: (_) => _entrar(),
        ),
        const SizedBox(height: 8),
        TextButton(onPressed: () {}, child: const Text('Forgot Password')),
        const SizedBox(height: 8),
        Center(
          child: SizedBox(
            width: 220,
            height: 52,
            child: FilledButton(
              onPressed: _entrar,
              style: FilledButton.styleFrom(shape: const StadiumBorder()),
              child: const Text('Login', style: TextStyle(fontSize: 18)),
            ),
          ),
        ),
      ],
    );
  }
}