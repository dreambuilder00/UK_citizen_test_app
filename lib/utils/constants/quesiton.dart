class Question {
  final int index;
  final String type;
  final String question;
  final List<String> answers;
  final int correct;

  Question({
    required this.index,
    required this.type,
    required this.question,
    required this.answers,
    required this.correct,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['index'] = index;
    data['type'] = type;
    data['question'] = question;
    data['answers'] = answers;
    data['correct'] = correct;

    return data;
  }

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      index: json['index'],
      type: json['type'],
      question: json['question'],
      answers: json['answers'],
      correct: json['correct'],
    );
  }
}
