// models/login.dart
class Login {
  final String username;
  final String password;

  const Login({required this.username, required this.password});

  /// Credenciais válidas do exercício.
  bool get isValid => username == 'admin' && password == '1234';
}