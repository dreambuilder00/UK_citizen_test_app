import 'package:red_squirrel/services/fetch_airtable.dart';
import 'package:red_squirrel/services/question_dao.dart';
import 'package:red_squirrel/utils/functions/convert_airtable_to_quiz.dart';

Future<void> storeData() async {
  List<dynamic> data = await getAllQuizzes();
  List.generate(data.length, (i) {
    QuizDao.insertQuiz(convertToQuiz(data[i]));
  });
}
