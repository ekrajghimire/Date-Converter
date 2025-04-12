import 'package:date_converter/screens/date_converter_screen.dart';
import 'package:flutter/material.dart';
import 'package:nepali_utils/nepali_utils.dart';

void main() {
  NepaliUtils(Language.nepali);
  runApp(const DateConverterApp());
}

class DateConverterApp extends StatefulWidget {
  const DateConverterApp({super.key});

  @override
  State<DateConverterApp> createState() => _DateConverterAppState();
}

class _DateConverterAppState extends State<DateConverterApp> {
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Date Converter',
      theme: isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: DateConverterScreen(
        isDarkMode: isDarkMode,
        onThemeToggle: () {
          setState(() {
            isDarkMode = !isDarkMode;
          });
        },
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
