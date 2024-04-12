// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:red_squirrel/core/models/quiz_model.dart';
import 'package:red_squirrel/core/repositories/quiz_repository.dart';

part 'quiz_event.dart';
part 'quiz_state.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  final QuizRepository quizRepository;

  QuizBloc({required this.quizRepository})
      : super(QuizState(quiz: QuizModel(), status: QuizStatus.initial)) {
    on<QuizLoadRequested>((event, emit) async {
      try {
        emit(state.copyWith(
          status: QuizStatus.loading,
        ));
        QuizModel? quiz = await quizRepository.getQuizByChapter(event.chapter,
            count: event.count);
        if (quiz == null) {
          emit(state.copyWith(
            status: QuizStatus.empty,
          ));
        } else {
          emit(state.copyWith(
            status: QuizStatus.success,
            quiz: quiz,
          ));
        }
      } catch (e) {
        // logger.e("ProfileLoadRequested error $e");
        emit(state.copyWith(status: QuizStatus.failure));
      }
    });
    on<QuizUpdated>((event, emit) async {
      emit(state.copyWith(quiz: event.quiz));
    });
  }
}
