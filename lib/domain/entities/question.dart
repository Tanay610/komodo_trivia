class Question {
  final String questionText;
  final List<String> options;
  final String correctOption;
  final String category;

  Question({
    required this.category,
    required this.questionText,
    required this.options,
    required this.correctOption,
  });


}
