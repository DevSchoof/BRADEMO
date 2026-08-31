// Para ler dados do console em Dart, usamos stdin.readLineSync() da biblioteca dart:io
// Complete o código abaixo importando a biblioteca correta e convertendo a idade recebida (que pode ser nula) para um número inteiro


// 1. Importe a biblioteca de E/S adequada para programas no console
import 'dart:io';

void main() {
  print("Digite sua idade:");

  // 2. Converta a entrada de console para int de forma segura (use int.parse e !)
  int idade = int.parse(stdin.readLineSync()!);

  print("Você tem $idade anos.");
}