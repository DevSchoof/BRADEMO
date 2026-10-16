import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(const MyApp());

// ===================== MODELO =====================
class Post {
  final int userId;
  final int id;
  final String title;
  final String body;

  Post(this.userId, this.id, this.title, this.body);

  String toJson() => jsonEncode({
        'userId': userId,
        'id': id,
        'title': title,
        'body': body,
      });

  static Post fromMap(Map<String, dynamic> m) =>
      Post(m['userId'], m['id'], m['title'], m['body']);

  static Post fromJson(String source) => fromMap(jsonDecode(source));
}

// ===================== SERVIÇO HTTP =====================
class PostService {
  static const _host = 'jsonplaceholder.typicode.com';
  static const _headers = {'Content-Type': 'application/json; charset=UTF-8'};

  // GET (lista)
  Future<List<Post>> getPosts() async {
    final r = await http.get(Uri.https(_host, 'posts'));
    if (r.statusCode != 200) throw Exception('Erro GET lista: ${r.statusCode}');
    final list = jsonDecode(r.body) as List<dynamic>;
    return list.map((e) => Post.fromMap(e as Map<String, dynamic>)).toList();
  }

  // GET (um item)
  Future<Post> getPost(int id) async {
    final r = await http.get(Uri.https(_host, 'posts/$id'));
    if (r.statusCode != 200) throw Exception('Post $id não encontrado (${r.statusCode})');
    return Post.fromJson(r.body);
  }

  // POST
  Future<Post> createPost(Post p) async {
    final r = await http.post(Uri.https(_host, 'posts'),
        headers: _headers, body: p.toJson());
    if (r.statusCode != 201) throw Exception('Erro POST: ${r.statusCode}');
    return Post.fromJson(r.body); // o servidor devolve id = 101
  }

  // PUT
  Future<Post> updatePost(Post p) async {
    final r = await http.put(Uri.https(_host, 'posts/${p.id}'),
        headers: _headers, body: p.toJson());
    if (r.statusCode != 200) throw Exception('Erro PUT: ${r.statusCode}');
    return Post.fromJson(r.body);
  }

  // DELETE
  Future<void> deletePost(int id) async {
    final r = await http.delete(Uri.https(_host, 'posts/$id'));
    if (r.statusCode != 200) throw Exception('Erro DELETE: ${r.statusCode}');
  }
}

// ===================== INTERFACE =====================
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'JSONPlaceholder CRUD',
        theme: ThemeData(colorSchemeSeed: Colors.green, useMaterial3: true),
        home: const PostsPage(),
      );
}

class PostsPage extends StatefulWidget {
  const PostsPage({super.key});

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  final _service = PostService();
  final _searchCtrl = TextEditingController();
  List<Post> _posts = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadPosts(); // chamado uma única vez (nunca dentro do build)
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  void _msg(String text) {
    if (!mounted) return;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(text)));
  }

  // GET lista
  Future<void> _loadPosts() async {
    setState(() => _loading = true);
    try {
      final posts = await _service.getPosts();
      if (!mounted) return;
      setState(() => _posts = posts);
    } catch (e) {
      _msg('$e');
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  // GET por id
  Future<void> _searchById() async {
    final id = int.tryParse(_searchCtrl.text.trim());
    if (id == null) return _msg('Informe um ID numérico');
    try {
      final p = await _service.getPost(id);
      if (!mounted) return;
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Post #${p.id}'),
          content: Text('${p.title}\n\n${p.body}\n\n(userId: ${p.userId})'),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Fechar'))
          ],
        ),
      );
    } catch (e) {
      _msg('$e');
    }
  }

  // Formulário para POST (post == null) ou PUT (post != null)
  Future<void> _openForm({Post? post}) async {
    final titleCtrl = TextEditingController(text: post?.title ?? '');
    final bodyCtrl = TextEditingController(text: post?.body ?? '');
    final editing = post != null;

    final ok = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(editing ? 'Editar post #${post.id} (PUT)' : 'Novo post (POST)'),
        content: SingleChildScrollView(
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            TextField(controller: titleCtrl, decoration: const InputDecoration(labelText: 'Título')),
            TextField(
                controller: bodyCtrl,
                decoration: const InputDecoration(labelText: 'Corpo'),
                maxLines: 4),
          ]),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancelar')),
          FilledButton(onPressed: () => Navigator.pop(context, true), child: const Text('Salvar')),
        ],
      ),
    );
    if (ok != true) return;

    try {
      if (editing) {
        final updated = await _service
            .updatePost(Post(post.userId, post.id, titleCtrl.text, bodyCtrl.text));
        // A API é fake e não persiste: atualizamos a lista local.
        setState(() {
          final i = _posts.indexWhere((p) => p.id == post.id);
          if (i != -1) _posts[i] = updated;
        });
        _msg('Post #${post.id} atualizado');
      } else {
        final created =
            await _service.createPost(Post(1, 0, titleCtrl.text, bodyCtrl.text));
        setState(() => _posts.insert(0, created));
        _msg('Post criado com id ${created.id}');
      }
    } catch (e) {
      _msg('$e');
    }
  }

  // DELETE
  Future<void> _delete(Post p) async {
    try {
      await _service.deletePost(p.id);
      setState(() => _posts.removeWhere((x) => x.id == p.id));
      _msg('Post #${p.id} removido');
    } catch (e) {
      _msg('$e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('JSONPlaceholder'),
        actions: [
          IconButton(
              tooltip: 'Recarregar (GET lista)',
              onPressed: _loadPosts,
              icon: const Icon(Icons.refresh)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Novo post (POST)',
        onPressed: () => _openForm(),
        child: const Icon(Icons.add),
      ),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Row(children: [
            Expanded(
              child: TextField(
                controller: _searchCtrl,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    labelText: 'Buscar post por ID (GET)', border: OutlineInputBorder()),
                onSubmitted: (_) => _searchById(),
              ),
            ),
            const SizedBox(width: 8),
            IconButton.filled(onPressed: _searchById, icon: const Icon(Icons.search)),
          ]),
        ),
        Expanded(
          child: _loading
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: _posts.length,
                  itemBuilder: (_, i) {
                    final p = _posts[i];
                    return ListTile(
                      leading: CircleAvatar(child: Text('${p.id}')),
                      title: Text(p.title, maxLines: 1, overflow: TextOverflow.ellipsis),
                      subtitle: Text(p.body, maxLines: 2, overflow: TextOverflow.ellipsis),
                      onTap: () => _openForm(post: p),
                      trailing: IconButton(
                        tooltip: 'Excluir (DELETE)',
                        icon: const Icon(Icons.delete_outline),
                        onPressed: () => _delete(p),
                      ),
                    );
                  },
                ),
        ),
      ]),
    );
  }
}