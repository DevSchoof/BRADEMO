// O modificador late indica ao compilador que a variável será inicializada posteriormente
// , e o operador ?? escolhe um valor reserva caso o primeiro seja nulo. 

void main() {
  // 1. Defina 'mensagem' como uma variável final de inicialização tardia
  late final String mensagem;

  mensagem = "Boas-vindas ao IFSP!";
  print(mensagem);

  String? usuarioAtivo = null;

  // 2. Se 'usuarioAtivo' for nulo, utilize o valor padrão "Convidado" usando o operador ??
  String exibirNome = usuarioAtivo ?? "Convidado";
  print("Usuário: $exibirNome");
}