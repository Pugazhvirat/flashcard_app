import 'package:flutter/material.dart';

import 'views/topic_selection_view.dart';

void main() {
  runApp(const FlashcardApp());
}

class FlashcardApp extends StatefulWidget {
  const FlashcardApp({super.key});

  @override
  State<FlashcardApp> createState() => _FlashcardAppState();
}

class _FlashcardAppState extends State<FlashcardApp> {
  bool _isDark = false;

  void toggleTheme() {
    setState(() => _isDark = !_isDark);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flashcard Learning App',
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      themeMode: _isDark ? ThemeMode.dark : ThemeMode.light,
      home: TopicSelectionScreen(onToggleTheme: toggleTheme, isDark: _isDark),
      debugShowCheckedModeBanner: false,
    );
  }
}
