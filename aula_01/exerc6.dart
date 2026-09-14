// O Dart utiliza o Null Safety para evitar falhas em tempo de execução
// Complete o código para que a variável apelido possa receber nulo e para forçar a impressão de apelido usando a garantia de asserção

void main() {
  // 1. Declare 'apelido' como uma String que PODE ser nula
  String? apelido;

  apelido = "Dudu";

  // 2. Adicione o operador que assegura que 'apelido' não é nulo na hora de imprimir
  print(apelido!);
}