import 'package:flutter/material.dart';
import 'package:progetto_cesare_pavese/pages/6_article_screen.dart';
import 'package:progetto_cesare_pavese/pages/2_home_screen.dart';
import 'package:progetto_cesare_pavese/pages/3_prequiz_screen.dart';
import 'package:progetto_cesare_pavese/pages/4_quiz_screen.dart';
import 'package:progetto_cesare_pavese/pages/1_start_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
  return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyStartPage(),
    );
  }
}
