import 'package:api_json/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'API JSON APP',
      showSemanticsDebugger: false,
      home: HomeScreen(),
    );
  }
}