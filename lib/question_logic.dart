import 'dart:math';

class Question {
  final String question;
  final List<String> options;
  final String correctAnswer;

  Question({
    required this.question,
    required this.options,
    required this.correctAnswer,
  });
}

class QuestionManager {
  List<Question> _questions = [
    Question(
      question:
          "Who protects the rule of law and ensures the supremacy of law?",
      options: ["Legislative", "Judiciary", "Executive", "Police"],
      correctAnswer: "Judiciary",
    ),
    Question(
      question: "Who makes and passes the laws?",
      options: ["Legislative", "Judiciary", "Executive", "Police"],
      correctAnswer: "Legislative",
    ),
    Question(
      question: "Who is known as the Father of the Indian Constitution?",
      options: [
        "Mahatma Gandhi",
        "Jawaharlal Nehru",
        "B.R. Ambedkar",
        "Sardar Patel"
      ],
      correctAnswer: "B.R. Ambedkar",
    ),
    Question(
      question: "Can the Constitution be amended?",
      options: ["True", "False"],
      correctAnswer: "Article 17",
    ),
    Question(
      question: "What is the role of the Legislative branch in a democracy?",
      options: [
        "To enforce laws",
        "To interpret laws",
        "To make laws",
        "To provide security"
      ],
      correctAnswer: "To make laws",
    ),
  ];

  List<Question> _remainingQuestions = [];

  QuestionManager() {
    _remainingQuestions = List.from(_questions);
  }

  Question getNextQuestion() {
    if (_remainingQuestions.isEmpty) {
      _remainingQuestions = List.from(_questions);
    }

    final random = Random();
    int index = random.nextInt(_remainingQuestions.length);
    return _remainingQuestions.removeAt(index);
  }
}
