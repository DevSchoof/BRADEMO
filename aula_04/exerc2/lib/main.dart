// Exercício 2 - Layout responsivo (retrato x paisagem), proporções do exemplo do slide.
// Todos os tamanhos (botões, textos, alturas) são proporcionais à largura da tela,
// então o resultado fica parecido com a imagem do slide em qualquer tamanho de janela.
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          elevation: 0,
          scrolledUnderElevation: 0,
          surfaceTintColor: Colors.transparent,
        ),
        dividerTheme: const DividerThemeData(color: Colors.white54, thickness: 1, space: 1),
        // Botões brancos, retangulares, sem sombra
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: Colors.grey,
            elevation: 0,
            padding: EdgeInsets.zero,
            minimumSize: Size.zero,
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          ),
        ),
      ),
      home: const Exercicio2(),
    );
  }
}

class Exercicio2 extends StatelessWidget {
  const Exercicio2({super.key});

  static const linguagens = ['Dart', 'JavaScript', 'PHP', 'C++'];

  Widget _botao(String texto, double largura, double altura, double fonte) {
    return SizedBox(
      width: largura,
      height: altura,
      child: ElevatedButton(
        onPressed: () {},
        child: Text(texto, style: TextStyle(fontSize: fonte, letterSpacing: fonte * 0.1)),
      ),
    );
  }

  // RETRATO: título + dois botões lado a lado (Row)
  Widget _cabecalhoRetrato(double p) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0.115 * p, 0.12 * p, 0.115 * p, 0.03 * p),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Cheetah Coding', style: TextStyle(fontSize: 0.083 * p, fontWeight: FontWeight.w500)),
          SizedBox(height: 0.07 * p),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _botao('BUTTON 1', 0.31 * p, 0.13 * p, 0.034 * p),
              _botao('BUTTON 2', 0.31 * p, 0.13 * p, 0.034 * p),
            ],
          ),
        ],
      ),
    );
  }

  // PAISAGEM: título + dois botões empilhados (Column)
  Widget _cabecalhoPaisagem(double p) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Cheetah Coding', style: TextStyle(fontSize: 0.041 * p, fontWeight: FontWeight.w500)),
        SizedBox(height: 0.04 * p),
        _botao('BUTTON 1', 0.33 * p, 0.067 * p, 0.017 * p),
        SizedBox(height: 0.034 * p),
        _botao('BUTTON 2', 0.33 * p, 0.067 * p, 0.017 * p),
      ],
    );
  }

  Widget _lista(double alturaItem, double fonte) {
    return ListView.builder(
      itemCount: linguagens.length,
      itemBuilder: (context, i) => Column(
        children: [
          SizedBox(
            height: alturaItem - 1,
            child: Center(child: Text(linguagens[i], style: TextStyle(fontSize: fonte, fontWeight: FontWeight.w500))),
          ),
          const Divider(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final p = MediaQuery.sizeOf(context).width; // unidade base: largura da tela
    final paisagem = MediaQuery.orientationOf(context) == Orientation.landscape;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: paisagem ? 0.054 * p : 0.10 * p,
        centerTitle: true,
        title: Text(
          'Responsive Layouts',
          style: TextStyle(
            fontSize: paisagem ? 0.017 * p : 0.036 * p,
            fontWeight: FontWeight.bold,
          ),
        ),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(),
        ),
      ),
      body: paisagem
          ? Row(
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: EdgeInsets.only(top: 0.07 * p),
                      // scaleDown evita overflow se a janela for muito baixa
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: _cabecalhoPaisagem(p),
                      ),
                    ),
                  ),
                ),
                const VerticalDivider(),
                Expanded(child: _lista(0.10 * p, 0.0225 * p)),
              ],
            )
          : Column(
              children: [
                _cabecalhoRetrato(p),
                Expanded(child: _lista(0.246 * p, 0.082 * p)),
              ],
            ),
    );
  }
}