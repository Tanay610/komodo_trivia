import 'package:flutter/material.dart';
import 'package:komodo_trivia/presentation/providers/score_provider.dart';
import 'package:provider/provider.dart';

class Options extends StatefulWidget {
  const Options({super.key, required this.option, required this.isCorrect});

  final String option;
  final bool isCorrect;

  @override
  State<Options> createState() => _OptionsState();
}

class _OptionsState extends State<Options> {
  String? currentOption;
  @override
  Widget build(BuildContext context) {
    ScoreProvider scoreProvider =
                Provider.of<ScoreProvider>(context, listen: false);
    return Column(
      children: [
        GestureDetector(
          onTap: () {
             scoreProvider.setSelectedOption(widget.option);
          },
          child: Container(
            height: 48,
            width: 270,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                  width: 3, color: Color.fromARGB(255, 164, 111, 177)),
            ),
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 18),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        widget.option,
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Radio(
                        value: widget.option,
                        groupValue: scoreProvider.selectedOption,
                        onChanged: (val) {
                          scoreProvider.setSelectedOption(val as String);
                        }),
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
  
}
