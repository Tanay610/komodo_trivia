
import 'package:flutter/material.dart';
import 'package:komodo_trivia/presentation/providers/quiz_provider.dart';
import 'package:komodo_trivia/presentation/providers/score_provider.dart';
import 'package:komodo_trivia/presentation/screens/splash_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (context)=> QuizProvider()),
      ChangeNotifierProvider(create: (context)=>ScoreProvider())
    ],
    child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  const SplashPage(),
    );
  }
}
