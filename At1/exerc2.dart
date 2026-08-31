//
//O Dart diferencia constantes avaliadas em tempo de compilação daquelas avaliadas em tempo de execução
// Complete o código abaixo utilizando const ou final para que a data atual (calculada em tempo de execução) funcione corretamente

void main() {
  // 1. Defina a constante do valor de PI (verificado em tempo de compilação)
  const num PI = 3.14;

  // 2. Defina a constante do horário atual (verificado em tempo de execução)
  final DateTime dataHoje = DateTime.now();

  print("PI: $PI");
  print("Hoje: $dataHoje");
}