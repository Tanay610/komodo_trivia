import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:komodo_trivia/domain/entities/categories.dart';
import 'package:komodo_trivia/domain/usecases/question_usecase.dart';
import 'package:komodo_trivia/presentation/screens/complete_page.dart';
import 'package:komodo_trivia/presentation/screens/quiz_page.dart';
import 'package:provider/provider.dart';
import '../../domain/entities/question.dart';
import 'package:http/http.dart' as http;

class QuizProvider extends ChangeNotifier {

 BuildContext? originalContext;

 List<TriviaCategory> categories = [];
  List responseData = [];
  List<String> shuffledOpt = [];
  int number = 0;
  int secondsRemaining = 20;
  Timer? _timer;

  List <String> get shuffleddOptions => shuffledOpt;

  TriviaCategory? selectedCategory;
  int? selectedCategoryId;

   void setSelectedCategoryId(int categoryId) {
    selectedCategoryId = categoryId;
    notifyListeners();
  }

  void setOriginalContext(BuildContext context) {
    originalContext = context;
    notifyListeners();
  }

  Future<void> loadCategories() async {
    try {
      final response = await http.get(Uri.parse('https://opentdb.com/api_category.php'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        categories = List<TriviaCategory>.from(data['trivia_categories'].map(
          (category) => TriviaCategory(
            name: category['name'],
            id: category['id'],
          ),
        ));
        selectedCategory = categories.isNotEmpty ? categories.first : null;
        if (selectedCategory != null) {
          setSelectedCategoryId(selectedCategory!.id);
        }
      } else {
        throw Exception('Failed to load categories');
      }
    } catch (error) {
      print('Error loading categories: $error');
    }
  }

  Future<void> syncApi() async {
    try {
      if (selectedCategoryId == null) {
        print('Category not selected');
        return;
      }

      final response = await http.get(Uri.parse("https://opentdb.com/api.php?amount=10&category=$selectedCategoryId"));

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body)['results'];
        responseData = List<String>.from(data);
        updateShuffleOptions();
        notifyListeners();
      }
    } catch (error) {
      print('Error syncing API: $error');
    }
  }


  void next() {
    if (number == 9) {
      completeQuiz();
    }
    number = number + 1;
    updateShuffleOptions();
    secondsRemaining = 20;
    notifyListeners();
  }

  void completeQuiz() {
    if (originalContext != null) {
      Navigator.push(
        originalContext!,
        MaterialPageRoute(builder: (context) => CompletePage()),
      );
    }
    
  }

  void updateShuffleOptions() {
    shuffledOpt = shuffledOptions([
      responseData[number]['correct_answer'],
      ...(responseData[number]['incorrect_answers'] as List),
    ]);
    notifyListeners();
  }

  List<String> shuffledOptions(List<String> option) {
    List<String> shuffledOpt = List.from(option);
    shuffledOpt.shuffle();
    notifyListeners();
    return shuffledOpt;
  }

  void startTimer() {
    _timer?.cancel(); // Cancel the previous timer if it exists
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (secondsRemaining > 0) {
        secondsRemaining--;
      } else {
        next();
        secondsRemaining = 20;
        updateShuffleOptions();
      }
    });
    notifyListeners();
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancel the timer when the provider is disposed
    super.dispose();
  }
}






