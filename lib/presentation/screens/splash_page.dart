import 'dart:async';
import 'package:flutter/material.dart';
import 'package:komodo_trivia/presentation/screens/home_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return const HomeScreen();
      }));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 37, 11, 20),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/icons8-quiz-64.png",
            color: Colors.white,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Komodo Trivia",
              style: TextStyle(
                  color: Colors.pink[100],
                  fontSize: 29,
                
                  fontWeight: FontWeight.w500),
            )
          ],
        ),
      ),
    );
  }
}
