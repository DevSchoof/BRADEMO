// Em Dart, declaramos membros privados adicionando um sublinhado (_) à frente de seu nome.
// Complete a classe para que firstName seja privado e inicializado automaticamente junto de lastName

class Pessoa {
  // 1. Declare o atributo String privado '_firstName'
  String _firstName;
  String lastName;

  // 2. Utilize o atalho 'this' no construtor para inicializar ambos os campos
  Pessoa(this._firstName, this.lastName);

  String sayName() {
    return "$lastName, $_firstName";
  }
}

void main() {
  Pessoa p = Pessoa("Amyr", "Klink");
  print(p.sayName()); // Deve exibir: Klink, Amyr
}