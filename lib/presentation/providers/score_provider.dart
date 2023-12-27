import 'package:flutter/material.dart';

class ScoreProvider extends ChangeNotifier {
  int _score = 0;
  int _correctAnswers = 0;
  int _incorrectAnswers = 0;
   String? _selectedOption;

  int get score => _score;

  int get correctAnswers => _correctAnswers;
  int get incorrectAnswers => _incorrectAnswers;
  String? get selectedOption => _selectedOption;

  
  int _userScore = 0;

  int get userScore => _userScore;

  void addCorrectAnswer() {
    _score += 10;
    _correctAnswers++;
    notifyListeners();
  }

  void addIncorrectAnswer() {
    _incorrectAnswers++;
    notifyListeners();
  }

  void updateUserScore(int score) {
    _userScore = score;
    notifyListeners();
  }

   void setSelectedOption(String? option) {
    _selectedOption = option;
    notifyListeners();
  }


  void resetScore() {
    _score = 0;
    _correctAnswers = 0;
    _incorrectAnswers = 0;
    _selectedOption = null;
    notifyListeners();
  }
}
