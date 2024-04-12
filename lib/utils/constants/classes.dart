class Quiz {
  final int id;
  final String question;
  final String optionA;
  final String optionB;
  final String optionC;
  final String optionD;
  final String answerA;
  final String answerB;
  final int chapter;
  final int type;
  final String feedback;

  const Quiz({
    required this.id,
    required this.question,
    required this.optionA,
    required this.optionB,
    required this.optionC,
    required this.optionD,
    required this.answerA,
    required this.answerB,
    required this.chapter,
    required this.type,
    required this.feedback,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['id'] = id;
    data['question'] = question;
    data['optionA'] = optionA;
    data['optionB'] = optionB;
    data['optionC'] = optionC;
    data['optionD'] = optionD;
    data['answerA'] = answerA;
    data['answerB'] = answerB;
    data['chapter'] = chapter;
    data['type'] = type;
    data['feedback'] = feedback;
    return data;
  }

  factory Quiz.fromJson(Map<String, dynamic> json) {
    return Quiz(
      id: json['id'],
      question: json['question'],
      optionA: json['optionA'],
      optionB: json['optionB'],
      optionC: json['optionC'],
      optionD: json['optionD'],
      answerA: json['answerA'],
      answerB: json['answerB'],
      chapter: json['chapter'],
      type: json['type'],
      feedback: json['feedback'],
    );
  }

  // Convert a Quiz into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'question': question,
      'option_a': optionA,
      'option_b': optionB,
      'option_c': optionC,
      'option_d': optionD,
      'answer_a': answerA,
      'answer_b': answerB,
      'chapter': chapter,
      'type': type,
      'feedback': feedback,
    };
  }
}
