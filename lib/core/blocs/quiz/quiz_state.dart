// part of 'quiz_bloc.dart';

// abstract class QuizState {}

// class QuizEmpty extends QuizState {}

// class QuizLoading extends QuizState {}

// class QuizLoaded extends QuizState {
//   final List<Quiz> quizzes;

//   QuizLoaded(this.quizzes);
// }

// class QuizError extends QuizState {
//   final String error;

//   QuizError(this.error);
// }

part of 'quiz_bloc.dart';

enum QuizStatus { initial, loading, empty, success, failure }

@immutable
class QuizState extends Equatable {
  final QuizModel quiz;
  final QuizStatus status;

  const QuizState({required this.quiz, this.status = QuizStatus.initial});

  QuizState copyWith({
    QuizModel? quiz,
    QuizStatus? status,
  }) {
    return QuizState(quiz: quiz ?? this.quiz, status: status ?? this.status);
  }

  @override
  List<Object?> get props => [status, quiz];
}
