// screens/login_screen.dart
import 'package:flutter/material.dart';
import '../widgets/login_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cores = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: cores.primary,
        foregroundColor: cores.onPrimary,
        title: const Text('Login Page'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 400),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Símbolo do Flutter + texto, lado a lado.
                        // Para usar seu logo: Image.asset('assets/logo.png', height: 100)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            FlutterLogo(size: 100),
                            SizedBox(width: 12),
                            Text(
                              'Flutter',
                              style: TextStyle(
                                fontSize: 48,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 32),
                        const LoginForm(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 16),
              child: Text('New User? Create Account'),
            ),
          ],
        ),
      ),
    );
  }
}