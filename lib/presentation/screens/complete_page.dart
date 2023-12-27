import 'package:flutter/material.dart';
import 'package:komodo_trivia/presentation/providers/score_provider.dart';
import 'package:komodo_trivia/presentation/screens/home_page.dart';
import 'package:komodo_trivia/presentation/screens/quiz_page.dart';
import 'package:provider/provider.dart';

class CompletePage extends StatelessWidget {
  const CompletePage({super.key,});


  @override
  Widget build(BuildContext context) {
    ScoreProvider score = Provider.of<ScoreProvider>(context, listen: false);
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 521,
            width: 415,
            child: Stack(
              children: [
                Container(
                  height: 340,
                  width: 420,
                  decoration: BoxDecoration(
                    color:  Colors.purple[300],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: CircleAvatar(
                      radius: 85,
                      backgroundColor: Colors.white.withOpacity(0.3),
                      child: CircleAvatar(
                        radius: 71,
                        backgroundColor: Colors.white.withOpacity(0.4),
                        child: CircleAvatar(
                          radius: 60,
                          backgroundColor: Colors.white,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text(
                                "Your score",
                                style: TextStyle(
                                    fontSize: 20, color: Color(0xffA42FC1)),
                              ),
                              RichText(
                                  text:  TextSpan(
                                      text: score.score.toString(),
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xffA42FC1)),
                                      children: [
                                    TextSpan(
                                        text: ' pt',
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Color(0xffA42FC1),
                                        ))
                                  ]))
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 60,
                  left: 29,
                    child: Container(
                  height: 190,
                  width: 350,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 5,
                            spreadRadius: 3,
                            color: const Color(0xffA42FC1).withOpacity(0.7),
                            offset: const Offset(0, 1))
                      ]),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 18),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Center(
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 15,
                                          width: 15,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Color(0xffA42FC1)),
                                        ),
                                        Text(
                                          ' ${score.correctAnswers*10}%',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 20,
                                              color: Color(0xffA42FC1)),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Text("Completion"),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Center(
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 15,
                                          width: 15,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Color(0xffA42FC1)),
                                        ),
                                        Text(
                                          ' 10',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 20,
                                              color: Color(0xffA42FC1)),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Text("Total Question"),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 20,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Center(
                                    child: Row( 
                                      children: [
                                        Container(
                                          height: 15,
                                          width: 15,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.green),
                                        ),
                                        Text(
                                          ' ${score.correctAnswers}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 20,
                                              color: Colors.green),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Text("Correct"),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 48 ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Center(
                                      child: Row(
                                        children: [
                                          Container(
                                            height: 15,
                                            width: 15,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.red),
                                          ),
                                          Text(
                                            ' ${score.incorrectAnswers}',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 20,
                                                color: Colors.red),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Text("Wrong"),
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ))
              ],
            ),
          ),
          SizedBox(height: 40,),
          Center(
            child: Padding(padding: EdgeInsets.symmetric(horizontal: 21),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context){
                          return HomeScreen();
                        }));
                      },
                      child: CircleAvatar(
                        radius: 35,
                        backgroundColor: Color(0xff327AFA1),
                        child: Center(
                          child: Icon(Icons.refresh,
                          size: 35,
                          color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text("Play Again",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500
                    ),
                    )
                  ],
                ),

                Column(
                  children: [
                    CircleAvatar(
                      radius: 35,
                      backgroundColor: Color(0xffCb9771),
                      child: Center(
                        child: Icon(Icons.visibility_rounded,
                        size: 35,
                        color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text("Review Answer",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500
                    ),
                    )
                  ],
                ),

                Column(
                  children: [
                    CircleAvatar(
                      radius: 35,
                      backgroundColor: Color(0xff327AFA1),
                      child: Center(
                        child: Icon(Icons.share,
                        size: 35,
                        color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text("Share Score",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500
                    ),
                    )
                  ],
                ),
              ],
            ),
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Center(
            child: Padding(padding: EdgeInsets.symmetric(horizontal: 18),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    CircleAvatar(
                      radius: 35,
                      backgroundColor: Color(0xff327AFA1),
                      child: Center(
                        child: Icon(Icons.file_copy_outlined,
                        size: 35,
                        color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text("Generate PDF",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500
                    ),
                    )
                  ],
                ),

                Column(
                  children: [
                    InkWell(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: CircleAvatar(
                        radius: 35,
                        backgroundColor: Color(0xffAD8AE8),
                        child: Center(
                          child: Icon(Icons.home,
                          size: 35,
                          color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text("Home",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500
                    ),
                    )
                  ],
                ),

                Column(
                  children: [
                    CircleAvatar(
                      radius: 35,
                      backgroundColor: Color(0xff5F6A6E),
                      child: Center(
                        child: Icon(Icons.settings_applications,
                        size: 35,
                        color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text("Leaderboard",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500
                    ),
                    )
                  ],
                ),
              ],
            ),
            ),
          ),
        ],
      ),
    );
  }
}
