import 'package:flutter/material.dart';
import 'package:komodo_trivia/presentation/providers/score_provider.dart';
import 'package:komodo_trivia/presentation/screens/complete_page.dart';
import 'package:komodo_trivia/presentation/widgets/opt_widget.dart';
import 'package:provider/provider.dart';
import '../providers/quiz_provider.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class QuizPage extends StatefulWidget {
  const QuizPage({
    super.key,
    required this.category,
  });

  final int category;

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List responseData = [];
  int number = 0;
  int question_no = 1;
  List<String> shuffledOpt = [];
  late Timer _timer;
  int secondsRemaining = 20;
  int userScore1 = 10;

  int get userScore => userScore1;
  String? selectedOption;

  Future syncApi() async {
    final response = await http.get(Uri.parse(
        "https://opentdb.com/api.php?amount=10&category=${widget.category}"));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['results'];
      setState(() {
        responseData = data;
        updateShuffleOptions();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    syncApi();
    startTimer();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    QuizProvider quizProvider2 =
        Provider.of<QuizProvider>(context, listen: false);
    ScoreProvider score = Provider.of<ScoreProvider>(context, listen: false);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            SizedBox(
              height: 421,
              width: 400,
              child: Stack(
                children: [
                  Container(
                    height: 240,
                    width: 400,
                    decoration: BoxDecoration(
                      color: Colors.purple[300],
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  Positioned(
                    bottom: 60,
                    left: 22,
                    child: Container(
                      height: 170,
                      width: 350,
                      decoration: BoxDecoration(
                        color: Colors.yellow[100],
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 1),
                            blurRadius: 6,
                            spreadRadius: 3,
                            color: Color.fromARGB(255, 172, 67, 170),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 18),
                        child: Column(
                          children: [
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "01",
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 20,
                                  ),
                                ),
                                Text(
                                  "09",
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                            Center(
                              child: Text(
                                "Question ${question_no+number}/10",
                                style: TextStyle(color: Color(0xffA42FC1)),
                              ),
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            Text(
                              (number >= 0 && number < responseData.length)
                                  ? responseData[number]['question']
                                      .replaceAll('&quot;', '\'')
                                      .replaceAll('&amp;', '&')
                                      .replaceAll('&#039;', '\'')
                                  : 'Loading.....',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400
                                  ),
                            )
                            // Text(responseData.isNotEmpty?responseData[number]['question'].replaceAll('&quot;', '\'').replaceAll('&amp;', '&').replaceAll('&#039;', '\''):''),
                            // Text(quizProvider2.responseData.isNotEmpty ? quizProvider2.responseData[0]['question'] : 'No question')
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                      bottom: 200,
                      left: 150,
                      child: CircleAvatar(
                        radius: 42,
                        backgroundColor: Colors.white,
                        child: Center(
                          child: Text(
                            secondsRemaining.toString(),
                            style: TextStyle(
                              color: Color(0xffA42FC1),
                              fontSize: 25,
                            ),
                          ),
                        ),
                      ))
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Column(
              children: (responseData.isNotEmpty &&
                      responseData[number]['incorrect_answers'] != null)
                  ? shuffledOpt.map((options) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: GestureDetector(
                            onTap: () {
                              checkAnswer();
                            },
                            child: Options(
                              option: options.toString().replaceAll("&#039;", '\'').replaceAll('&quot;', ''),
                              isCorrect: false,
                            )),
                      );
                    }).toList()
                  : [],
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.purple[300],
                      //Color(0xffA42FC1)
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 6),
                  onPressed: () {
                    checkAnswer();
                    next();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    child: const Text(
                      "Next",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }

  void next() {
    if (number == 9) {
      completeQuiz();
    }
    setState(() {
      number = number + 1;
      updateShuffleOptions();
      secondsRemaining = 20;
    });
  }

  void completeQuiz() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => CompletePage()));
  }

  void updateShuffleOptions() {
    if (number >= 0 && number <= 9) {
      setState(() {
        shuffledOpt = shuffledOptions([
          responseData[number]['correct_answer'],
          ...(responseData[number]['incorrect_answers'] as List)
        ]);
      });
    } else {
      // throw Exception("Index range out of bounds!!!");
      number = 0;
    }
  }

  List<String> shuffledOptions(List<String> option) {
    List<String> shuffledOpt = List.from(option);
    shuffledOpt.shuffle();
    return shuffledOpt;
  }

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (secondsRemaining > 0) {
          secondsRemaining--;
        } else {
          next();
          secondsRemaining = 20;
          updateShuffleOptions();
        }
      });
    });
  }

  void checkAnswer() {
    String score = Provider.of<ScoreProvider>(context, listen: false)
        .selectedOption
        .toString();
    String correctOption = responseData[number]['correct_answer'];
    if (score == correctOption) {
      Provider.of<ScoreProvider>(context, listen: false).addCorrectAnswer();
    } else if(score!= correctOption){
      Provider.of<ScoreProvider>(context, listen: false).addIncorrectAnswer();
    }
  }
}
