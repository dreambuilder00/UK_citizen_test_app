// part of 'quiz_bloc.dart';

// abstract class QuizEvent {}

// class LoadQuiz extends QuizEvent {}
part of 'quiz_bloc.dart';

abstract class QuizEvent extends Equatable {
  const QuizEvent();

  @override
  List<Object> get props => [];
}

class QuizLoaded extends QuizEvent {
  final QuizModel quiz;

  const QuizLoaded(this.quiz);

  @override
  List<Object> get props => [quiz];
}

class QuizLoadRequested extends QuizEvent {
  final List<int> chapter;
  final int count;

  const QuizLoadRequested(this.chapter, this.count);

  @override
  List<Object> get props => [chapter, count];
}

class QuizUpdated extends QuizEvent {
  final QuizModel quiz;

  const QuizUpdated(this.quiz);

  @override
  List<Object> get props => [quiz];
}
