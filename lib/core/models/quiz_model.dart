import 'package:red_squirrel/utils/constants/classes.dart';

class QuizModel {
  final List<Quiz>? quizzes;
  final List<List<String>>? answers;

  QuizModel({
    this.quizzes,
    this.answers,
  });

  QuizModel copyWith({
    List<Quiz>? quizzes,
    List<List<String>>? answers,
  }) {
    return QuizModel(
        quizzes: quizzes ?? this.quizzes, answers: answers ?? this.answers);
  }

  factory QuizModel.fromSnapsot(Map<String, dynamic> snapshot) {
    return QuizModel(
      quizzes: List<Quiz>.from(
          snapshot['quizzes'].map((i) => Quiz.fromJson(i)).toList() ?? []),
      answers: List<List<String>>.from(snapshot['answers'] ?? []),
    );
  }

  Map<String, dynamic> toMap() => {
        'quizzes': quizzes!.map((e) => e.toJson()).toList(),
        'answers': answers,
      };
}

// class QuizModel {
//   final int? id;
//   final int? chapter;
//   final String? question;
//   final List<String>? options;
//   final int? answer;
//   final String? feedback;
//   final int? type;

//   QuizModel({
//     this.id,
//     this.chapter,
//     this.question,
//     this.options,
//     this.answer,
//     this.feedback,
//     this.type,
//   });

//   QuizModel copyWith({
//     int? id,
//     int? chapter,
//     String? question,
//     List<String>? options,
//     int? answer,
//     String? feedback,
//     int? type,
//   }) {
//     return QuizModel(
//       id: id ?? this.id,
//       chapter: chapter ?? this.chapter,
//       question: question ?? this.question,
//       options: options ?? this.options,
//       answer: answer ?? this.answer,
//       feedback: feedback ?? this.feedback,
//       type: type ?? this.type,
//     );
//   }

//   factory QuizModel.fromSnapshot(Map<String, dynamic> snapshot) {
//     return QuizModel(
//       id: snapshot['id'],
//       chapter: snapshot['chapter'],
//       question: snapshot['question'],
//       options: List<String>.from(snapshot['options'] ?? []),
//       answer: snapshot['answer'],
//       feedback: snapshot['feedback'],
//       type: snapshot['type'],
//     );
//   }

//   Map<String, dynamic> toMap() => {
//         'id': id,
//         'chapter': chapter,
//         'question': question,
//         'options': options,
//         'answer': answer,
//         'feedback': feedback,
//         'type': type,
//       };
// }
