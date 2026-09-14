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
          title: const Text('Stack & Positioned Widget'),
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 20, ),
          centerTitle: true,
          backgroundColor: Colors.blue,
        ),
        body: const StackLayoutScreen(),
      ),
    );
  }
}

class StackLayoutScreen extends StatelessWidget {
  const StackLayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Stack(
        children: [
          Positioned(
            top: 20,
            left: 20,
            child: Container(
              width: 150,
              height: 180,
              color: Colors.green.shade400,
              padding: const EdgeInsets.all(8),
              child: const Text(
                'Green',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ),
          Positioned(
            top: 45,
            left: 45,
            child: Container(
              width: 150,
              height: 180,
              color: Colors.red.shade400,
              padding: const EdgeInsets.all(8),
              child: const Text(
                'Red',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ),
          Positioned(
            top: 70,
            left: 70,
            child: Container(
              width: 150,
              height: 180,
              color: Colors.purple.shade300,
              padding: const EdgeInsets.all(8),
              child: const Text(
                'Purple',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}