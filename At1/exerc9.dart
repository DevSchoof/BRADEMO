// Complete a função cadastrarFuncionario usando parâmetros nomeados (sendo nome obrigatório e cargo opcional)
//, e complete o método multiplicar com sintaxe de seta (=>)

// 1. Complete os parâmetros nomeados (nome obrigatório, cargo que aceita nulo)
void cadastrarFuncionario({required String nome, String? cargo}) {
  print("Boas-vindas, $nome!");
  if (cargo != null) {
    print("Cargo: $cargo");
  }
}

// 2. Converta esta função para uma Arrow Function compacta
int multiplicar(int a, int b) => a * b;

void main() {
  cadastrarFuncionario(nome: "Ana", cargo: "Analista");
  print("Resultado: ${multiplicar(5, 4)}");
}