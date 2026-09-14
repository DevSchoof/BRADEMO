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
          title: const Text('Insert Image Example'),
          titleTextStyle: TextStyle(color: Colors.yellow, fontSize: 20, ),
          backgroundColor: Colors.blue,
        ),
        body: const ImageExampleScreen(),
      ),
    );
  }
}

class ImageExampleScreen extends StatelessWidget {
  const ImageExampleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          SizedBox(
            height: 150,
            width: double.infinity,
            child: FittedBox(
              fit: BoxFit.cover,
              child: Image.network(
                'https://picsum.photos/id/1016/600/300',
              ),
            ),
          ),
          const SizedBox(height: 30),
          SizedBox(
            height: 250,
            width: double.infinity,
            child: FittedBox(
              fit: BoxFit.cover,
              child: Image.network(
                'https://picsum.photos/id/1024/600/400',
              ),
            ),
          ),
        ],
      ),
    );
  }
}