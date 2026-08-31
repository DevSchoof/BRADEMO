// O operador de cascata permite realizar operações consecutivas sobre o mesmo objeto sem repetir seu nome
// Complete as lacunas para realizar a configuração de A, de B e exibir o resultado

class Demo {
  int a = 0;
  int b = 0;

  void setA(int val) => a = val;
  void setB(int val) => b = val;
  void showVal() => print("Valores - A: $a, B: $b");
}

void main() {
  Demo d = Demo();

  // 1. Use a cascata (..) para definir A como 50, B como 60 e chamar showVal na mesma linha
  d
    ..setA(50)
    ..setB(60)
    ..showVal();
}