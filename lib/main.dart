import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const DateConverterApp());
}

class DateConverterApp extends StatelessWidget {
  const DateConverterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Date Converter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.indigo, useMaterial3: true),
      home: const DateConverterScreen(),
    );
  }
}
