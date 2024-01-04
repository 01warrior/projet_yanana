import 'package:flutter/material.dart';
import 'package:yanana/vue/page_introductive.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Yanana',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent.shade700),
        useMaterial3: true,
      ),
      home:PageIntroductive(),
    );
  }
}
