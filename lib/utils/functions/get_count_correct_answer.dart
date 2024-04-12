import 'package:red_squirrel/core/models/quiz_model.dart';
import 'package:red_squirrel/utils/functions/array_function.dart';

int getCountCorrectAnswer(QuizModel quiz, int count) {
  int correct = 0;
  for (var i = 0; i < count; i++) {
    bool isEqual = compareArrays(
        [quiz.quizzes![i].answerA, quiz.quizzes![i].answerB], quiz.answers![i]);
    if (isEqual) correct++;
  }
  return correct;
}
