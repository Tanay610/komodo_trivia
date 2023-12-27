import '../entities/question.dart';

abstract class QuizRepository {
  Future<List<Question>> getQuestions(String category, int amount);
}
