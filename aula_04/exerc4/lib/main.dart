// Exercício 4 - Form (Column + Row) com SnackBar ao enviar
// Todos os tamanhos são proporcionais à largura da tela (w), para ficar com as
// mesmas proporções do exemplo do slide em qualquer tamanho de janela.
import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      // Material 2 (visual clássico do slide): barra azul, campos com sublinhado.
      theme: ThemeData(
        useMaterial3: false,
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const Exercicio4(),
    ));

class Exercicio4 extends StatefulWidget {
  const Exercicio4({super.key});

  @override
  State<Exercicio4> createState() => _Exercicio4State();
}

class _Exercicio4State extends State<Exercicio4> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _telefoneController = TextEditingController();
  final _dobController = TextEditingController();

  @override
  void dispose() {
    _nomeController.dispose();
    _telefoneController.dispose();
    _dobController.dispose();
    super.dispose();
  }

  Future<void> _selecionarData() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      final d = picked.day.toString().padLeft(2, '0');
      final m = picked.month.toString().padLeft(2, '0');
      _dobController.text = '$d/$m/${picked.year}';
    }
  }

  // Linha do formulário: ícone + campo expandido (Row dentro de Column)
  Widget _linha(double w, IconData icone, Widget campo) {
    return Container(
      constraints: BoxConstraints(minHeight: 0.14 * w),
      padding: EdgeInsets.symmetric(horizontal: 0.025 * w),
      alignment: Alignment.center,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // sobe o ícone para ficar alinhado com o texto (e não com a linha)
          Padding(
            padding: EdgeInsets.only(bottom: 0.032 * w),
            child: Icon(icone, size: 0.062 * w, color: Colors.grey[800]),
          ),
          SizedBox(width: 0.04 * w),
          Expanded(child: campo),
        ],
      ),
    );
  }

  InputDecoration _decoracao(double w, String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(fontSize: 0.043 * w, color: Colors.grey[600]),
      isDense: true,
      // mais espaço embaixo do texto: afasta o texto da linha, como no slide
      contentPadding: EdgeInsets.only(top: 0.03 * w, bottom: 0.062 * w),
    );
  }

  String? _obrigatorio(String? v) =>
      (v == null || v.trim().isEmpty) ? 'Por favor insira algum texto' : null;

  void _enviar() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Nome: ${_nomeController.text} | '
            'Telefone: ${_telefoneController.text} | '
            'Nascimento: ${_dobController.text}',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width; // unidade base: largura da tela
    final estiloCampo = TextStyle(fontSize: 0.043 * w, color: Colors.black87);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0.145 * w,
        titleSpacing: 0.032 * w,
        elevation: 0,
        title: Text(
          'Flutter Form Demo',
          style: TextStyle(fontSize: 0.046 * w, fontWeight: FontWeight.bold),
        ),
      ),
      body: Form(
        key: _formKey,
        // rolagem evita overflow em janelas baixas
        child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 0.02 * w),
            _linha(
              w,
              Icons.person,
              TextFormField(
                controller: _nomeController,
                style: estiloCampo,
                decoration: _decoracao(w, 'Name'),
                validator: _obrigatorio,
              ),
            ),
            _linha(
              w,
              Icons.phone,
              TextFormField(
                controller: _telefoneController,
                style: estiloCampo,
                keyboardType: TextInputType.phone,
                decoration: _decoracao(w, 'Phone'),
                validator: _obrigatorio,
              ),
            ),
            _linha(
              w,
              Icons.calendar_today,
              TextFormField(
                controller: _dobController,
                style: estiloCampo,
                readOnly: true,
                onTap: _selecionarData,
                decoration: _decoracao(w, 'Dob'),
                validator: _obrigatorio,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 0.15 * w),
              child: ElevatedButton(
                onPressed: _enviar,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[400],
                  foregroundColor: Colors.grey[700],
                  elevation: 0,
                  // folga ao redor do texto, como no slide
                  padding: EdgeInsets.symmetric(
                    horizontal: 0.06 * w,
                    vertical: 0.06 * w,
                  ),
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  textStyle: TextStyle(fontSize: 0.03 * w),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                ),
                child: const Text('Submit'),
              ),
            ),
          ],
        ),
        ),
      ),
    );
  }
}