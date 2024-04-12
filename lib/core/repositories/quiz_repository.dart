import 'package:red_squirrel/core/models/quiz_model.dart';
import 'package:red_squirrel/services/question_dao.dart';
import 'package:red_squirrel/utils/constants/classes.dart';

class QuizRepository {
  Future<QuizModel?> getQuizByChapter(List<int> chapter,
      {int count = 24}) async {
    try {
      List<Quiz> quizzes = await QuizDao.getQuiz(chapter, count);
      List<List<String>> answers = [];
      for (int i = 0; i < count; i++) {
        answers.add([]);
      }

      return QuizModel(quizzes: quizzes, answers: answers);
    } catch (e) {
      return null;
    }
  }
}
