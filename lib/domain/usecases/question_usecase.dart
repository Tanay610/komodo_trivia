import 'package:komodo_trivia/domain/entities/question.dart';

import '../repositories/quiz_repository.dart';

class GetQuestionsUseCase {
  final QuizRepository repository;

  GetQuestionsUseCase(this.repository);

  Future<List<Question>> execute(String category, int amount) {
    return repository.getQuestions(category, amount);
  }
}
