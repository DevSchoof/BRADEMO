// Exercício 5 - FloatingActionButton ao centro de um BottomAppBar.
// Ao tocar no "+" aparecem as opções (chat, e-mail e telefone) acima do botão.
// Os tamanhos são proporcionais à largura da tela (w), como no exemplo do slide.
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // Material 2 (visual do slide): barra azul, botão redondo azul.
      // O tema fica aqui (e não no main) para o hot reload também atualizá-lo.
      theme: ThemeData(
        useMaterial3: false,
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const Exercicio5(),
    );
  }
}

class Exercicio5 extends StatefulWidget {
  const Exercicio5({super.key});

  @override
  State<Exercicio5> createState() => _Exercicio5State();
}

class _Exercicio5State extends State<Exercicio5> {
  int _tab = 3; // como no slide: "TAB: 3" e "Bar" em vermelho
  // Opções do FAB visíveis? Começa aberto para ficar igual ao slide;
  // tocar no "+" abre/fecha. Troque para false para começar fechado.
  bool _aberto = true;

  static const _itens = [
    (Icons.menu, 'This'),
    (Icons.layers, 'Is'),
    (Icons.dashboard, 'Bottom'),
    (Icons.info, 'Bar'),
  ];

  // Item da barra inferior: cinza, ou vermelho quando selecionado
  Widget _botaoTab(double w, int index) {
    final cor = _tab == index ? Colors.red : Colors.grey;
    return Expanded(
      child: InkWell(
        onTap: () => setState(() => _tab = index),
        child: Center(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(_itens[index].$1, size: 0.075 * w, color: cor),
                Text(_itens[index].$2,
                    style: TextStyle(fontSize: 0.04 * w, color: cor)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Opção que aparece acima do FAB: círculo branco com ícone azul
  Widget _opcao(double w, IconData icone, String nome) {
    return Padding(
      padding: EdgeInsets.only(bottom: 0.09 * w),
      child: Tooltip(
        message: nome,
        child: Material(
          color: Colors.white,
          elevation: 3,
          shape: const CircleBorder(),
          child: InkWell(
            customBorder: const CircleBorder(),
            onTap: () {
              setState(() => _aberto = false);
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text('Opção: $nome')));
            },
            child: SizedBox(
              width: 0.1 * w,
              height: 0.1 * w,
              child: Icon(icone, size: 0.05 * w, color: Colors.blue),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width; // unidade base: largura da tela

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        toolbarHeight: 0.19 * w,
        title: Text(
          'BottomAppBar with FAB',
          style: TextStyle(fontSize: 0.042 * w, fontWeight: FontWeight.w500),
        ),
      ),
      body: Stack(
        children: [
          Center(
            child: Text('TAB: $_tab', style: TextStyle(fontSize: 0.09 * w)),
          ),
          // Opções do FAB (só aparecem depois de tocar no "+")
          if (_aberto)
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: 0.05 * w),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _opcao(w, Icons.message, 'Chat'),
                    _opcao(w, Icons.mail, 'E-mail'),
                    _opcao(w, Icons.phone, 'Telefone'),
                  ],
                ),
              ),
            ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: SizedBox(
        width: 0.143 * w,
        height: 0.143 * w,
        child: FloatingActionButton(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          onPressed: () => setState(() => _aberto = !_aberto),
          child: Icon(Icons.add, size: 0.07 * w),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        shape: const CircularNotchedRectangle(),
        notchMargin: 0.02 * w,
        padding: EdgeInsets.zero,
        height: 0.16 * w,
        child: Row(
          children: [
            _botaoTab(w, 0),
            _botaoTab(w, 1),
            // espaço do FAB, com o rótulo "A" (como no slide)
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 0.075 * w),
                  Text('A',
                      style: TextStyle(fontSize: 0.04 * w, color: Colors.grey)),
                ],
              ),
            ),
            _botaoTab(w, 2),
            _botaoTab(w, 3),
          ],
        ),
      ),
    );
  }
}