// Exercício 6 - App de lista de tarefas
// ListView.builder + Card + Checkbox + ElevatedButton + FloatingActionButton + AlertDialog.
// Os tamanhos são proporcionais à largura da tela (w), como no exemplo do slide.
import 'package:flutter/material.dart';

// ===== Ajustes finos (valores são proporções da largura da tela) =====
// Valores MEDIDOS no slide (em pixels, no print) e convertidos para proporção da largura.
// A faixa azul do slide inclui a área da barra de status do celular (hora, sinal),
// por isso é mais alta: 0,24 da largura. O título fica na parte de baixo dela.
const kAlturaAppBar = 0.24; // altura total da faixa azul
const kDeslocTitulo = 0.048; // quanto o título desce em relação ao centro da faixa
const kFonteTitulo = 0.056; // "Kindacode.com"
const kMargemH = 0.05; // margem esquerda/direita da tela
const kEspacoTopo = 0.07; // barra azul -> botão
// botão "View Completed Tasks"
const kFonteBotao = 0.035;
const kPesoBotao = FontWeight.w500;
const kPadBotaoH = 0.061;
const kPadBotaoV = 0.0255;
// texto "You have 5 uncompleted tasks"
const kFonteLinha = 0.05;
const kPesoLinha = FontWeight.w600; // medido: no slide o peso é ~1,5x o do w400
const kEspacoAposBotao = 0.074; // botão -> texto
const kEspacoAntesCartoes = 0.07; // texto -> 1º cartão
// cartões
const kFonteCartao = 0.045;
const kPesoCartao = FontWeight.w500;
const kAlturaLinhaCartao = 1.05; // espaçamento entre as 2 linhas do texto do cartão
const kPadCartaoE = 0.047; // padding esquerdo (texto)
const kPadCartaoD = 0.075; // padding direito (caixa de seleção)
const kPadCartaoV = 0.023; // padding vertical
const kEspacoCartoes = 0.082; // espaço entre cartões
const kCheckbox = 0.057; // tamanho da caixa de seleção

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // Material 2 (visual do slide). O tema fica aqui (e não no main)
      // para o hot reload também atualizá-lo.
      theme: ThemeData(
        useMaterial3: false,
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const Exercicio6(),
    );
  }
}

class Tarefa {
  final String titulo;
  bool concluida;
  Tarefa(this.titulo, {this.concluida = false});
}

class Exercicio6 extends StatefulWidget {
  const Exercicio6({super.key});

  @override
  State<Exercicio6> createState() => _Exercicio6State();
}

class _Exercicio6State extends State<Exercicio6> {
  // "Task 2022-07-09" e, na linha de baixo, "18:08:31.734244"
  final List<Tarefa> _tarefas = List.generate(5, (i) {
    final partes = DateTime.now().add(Duration(seconds: i)).toString().split(' ');
    return Tarefa('Task ${partes[0]}\n${partes[1]}');
  });
  bool _mostrarConcluidas = false;

  int get _pendentes => _tarefas.where((t) => !t.concluida).length;

  void _abrirDialogo() {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Aviso'),
        content: const Text('Você está no App de Notas de Tarefas'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  // Cartão amarelo: texto à esquerda, caixa de seleção à direita
  Widget _cartao(double w, Tarefa tarefa) {
    return Card(
      color: Colors.amberAccent,
      margin: EdgeInsets.only(bottom: kEspacoCartoes * w),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.02 * w)),
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          kPadCartaoE * w,
          kPadCartaoV * w,
          kPadCartaoD * w,
          kPadCartaoV * w,
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                tarefa.titulo,
                style: TextStyle(
                  fontSize: kFonteCartao * w,
                  height: kAlturaLinhaCartao,
                  fontWeight: kPesoCartao,
                  color: Colors.black87,
                ),
              ),
            ),
            // FittedBox ajusta o tamanho da caixa de seleção à tela
            SizedBox(
              width: kCheckbox * w,
              height: kCheckbox * w,
              child: FittedBox(
                child: Checkbox(
                  value: tarefa.concluida,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  onChanged: (v) => setState(() => tarefa.concluida = v ?? false),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width; // unidade base: largura da tela

    // Mostra só pendentes ou só concluídas, conforme o botão
    final visiveis =
        _tarefas.where((t) => t.concluida == _mostrarConcluidas).toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        toolbarHeight: kAlturaAppBar * w,
        // O padding em cima empurra o título para baixo (metade do valor),
        // como no slide, onde a parte de cima da faixa é a barra de status.
        title: Padding(
          padding: EdgeInsets.only(top: 2 * kDeslocTitulo * w),
          child: Text(
            'Kindacode.com',
            style: TextStyle(
              fontSize: kFonteTitulo * w,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
      // Uma única lista com rolagem (botão + texto + cartões): não estoura
      // a altura em janelas baixas.
      body: ListView.builder(
        padding: EdgeInsets.fromLTRB(kMargemH * w, kEspacoTopo * w, kMargemH * w, 0.25 * w),
        itemCount: visiveis.length + 2,
        itemBuilder: (context, index) {
          if (index == 0) {
            return Align(
              alignment: Alignment.centerLeft,
              child: ElevatedButton(
                onPressed: () =>
                    setState(() => _mostrarConcluidas = !_mostrarConcluidas),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  elevation: 1,
                  padding: EdgeInsets.symmetric(
                    horizontal: kPadBotaoH * w,
                    vertical: kPadBotaoV * w,
                  ),
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  // No Linux/desktop o padrão é a densidade "compacta", que tira ~8 px
                  // do padding vertical do botão. Aqui usamos a densidade normal.
                  visualDensity: VisualDensity.standard,
                  textStyle: TextStyle(
                    fontSize: kFonteBotao * w,
                    height: 1.0,
                    fontWeight: kPesoBotao,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0.012 * w),
                  ),
                ),
                child: Text(_mostrarConcluidas
                    ? 'View Uncompleted Tasks'
                    : 'View Completed Tasks'),
              ),
            );
          }
          if (index == 1) {
            return Padding(
              padding: EdgeInsets.only(
                top: kEspacoAposBotao * w,
                bottom: kEspacoAntesCartoes * w,
              ),
              child: Text(
                _mostrarConcluidas
                    ? 'You have ${_tarefas.length - _pendentes} completed tasks'
                    : 'You have $_pendentes uncompleted tasks',
                style: TextStyle(
                  fontSize: kFonteLinha * w,
                  height: 1.0,
                  fontWeight: kPesoLinha,
                ),
              ),
            );
          }
          return _cartao(w, visiveis[index - 2]);
        },
      ),
      floatingActionButton: Transform.translate(
        offset: Offset(0.019 * w, 0), // aproxima da borda direita, como no slide
        child: SizedBox(
          width: 0.14 * w,
          height: 0.14 * w,
          child: FloatingActionButton(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            onPressed: _abrirDialogo,
            child: Icon(Icons.add, size: 0.07 * w),
          ),
        ),
      ),
    );
  }
}