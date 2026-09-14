import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter is Fun!'),
          backgroundColor: Colors.green,
        ),
        body: const AlignmentLayout(),
      ),
    );
  }
}

class AlignmentLayout extends StatelessWidget {
  const AlignmentLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Container(
        width: 120,
        height: 120,
        color: Colors.redAccent,
        padding: const EdgeInsets.all(8.0),
        child: const Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hi Mom ',
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
            Icon(
              Icons.local_fire_department,
              color: Colors.amber,
            ),
          ],
        ),
      ),
    );
  }
}