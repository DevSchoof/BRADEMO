import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Exercicio1(),
    ));

class Foto {
  final String url;
  final String nome;
  const Foto(this.url, this.nome);
}

String _capitalizar(String s) =>
    s.isEmpty ? s : s[0].toUpperCase() + s.substring(1);

// "hound-afghan" -> "Afghan Hound" | "pug" -> "Pug"
String _nomeDaRaca(String url) {
  final segmentos = Uri.parse(url).pathSegments; // [breeds, hound-afghan, x.jpg]
  final i = segmentos.indexOf('breeds');
  final raca = (i >= 0 && i + 1 < segmentos.length) ? segmentos[i + 1] : 'desconhecida';
  return raca.split('-').reversed.map(_capitalizar).join(' ');
}

Future<List<Foto>> buscarFotos() async {
  final resposta =
      await http.get(Uri.parse('https://dog.ceo/api/breeds/image/random/6'));
  if (resposta.statusCode != 200) {
    throw Exception('Erro ${resposta.statusCode} ao buscar imagens');
  }
  final urls = List<String>.from(jsonDecode(resposta.body)['message'] as List);
  return urls.map((u) => Foto(u, _nomeDaRaca(u))).toList();
}

class Exercicio1 extends StatefulWidget {
  const Exercicio1({super.key});

  @override
  State<Exercicio1> createState() => _Exercicio1State();
}

class _Exercicio1State extends State<Exercicio1> {
  late Future<List<Foto>> _fotos;

  @override
  void initState() {
    super.initState();
    _fotos = buscarFotos();
  }

  void _recarregar() => setState(() => _fotos = buscarFotos());

  Widget _buildItem(Foto foto) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(6),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            foto.url,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, progress) => progress == null
                ? child
                : const Center(child: CircularProgressIndicator()),
            errorBuilder: (context, error, stack) => Container(
              color: Colors.grey[300],
              child: const Icon(Icons.broken_image, size: 40),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              color: Colors.black54,
              padding: const EdgeInsets.all(8),
              child: Text(
                'Cachorro\n${foto.nome}',
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Sem AppBar, como no exemplo do slide. SafeArea evita que os cards
    // fiquem sob a barra de status.
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<List<Foto>>(
          future: _fotos,
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('Não foi possível carregar as imagens.'),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: _recarregar,
                      child: const Text('Tentar de novo'),
                    ),
                  ],
                ),
              );
            }
            final fotos = snapshot.data!;
            // Arrastar para baixo busca outras imagens (e outros nomes)
            return RefreshIndicator(
              onRefresh: () async {
                _recarregar();
                try {
                  await _fotos;
                } catch (_) {}
              },
              child: GridView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(4),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 4,
                  crossAxisSpacing: 4,
                ),
                itemCount: fotos.length,
                itemBuilder: (context, index) => _buildItem(fotos[index]),
              ),
            );
          },
        ),
      ),
    );
  }
}