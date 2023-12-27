import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:komodo_trivia/presentation/screens/quiz_page.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class LoadingScreen extends StatefulWidget {
  final int index;
  final String selectedDif;
  const LoadingScreen({super.key, required this.index, required this.selectedDif});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance?.addPostFrameCallback((_) {
      Timer(const Duration(milliseconds: 800), () {
        Navigator.pushReplacement(context, (MaterialPageRoute(builder: (context){
          return QuizPage(category: widget.index);
        })));
      });
    });
  }

  Future<bool> checkConnectivity() async {
    bool result = await InternetConnectionChecker().hasConnection;
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [
            Color.fromARGB(255, 241, 233, 139), Color.fromARGB(255, 205, 169, 242),
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: LoadingAnimationWidget.inkDrop(
            color: Colors.white,
            size: 50,
          ),
        ),
      ),
    );
  }
}
