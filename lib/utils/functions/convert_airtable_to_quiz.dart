import 'package:red_squirrel/utils/constants/classes.dart';

Quiz convertToQuiz(dynamic record) {
  int type;
  if (record['fields']['option_d'] != null) {
    if (record['fields']['correct_answer'].length == 1) {
      type = 1;
    } else {
      type = 2;
    }
  } else {
    if (record['fields']['option_a'] != "True") {
      type = 3;
    } else {
      type = 4;
    }
  }

  return Quiz(
    id: record['fields']['question_id'],
    question: record['fields']['question_text'],
    optionA: record['fields']['option_a'],
    optionB: record['fields']['option_b'],
    optionC: record['fields']['option_c'] ?? "",
    optionD: record['fields']['option_d'] ?? "",
    answerA: record['fields']['correct_answer'][0],
    answerB: record['fields']['correct_answer'].length == 2
        ? record['fields']['correct_answer'][1]
        : "",
    chapter: int.parse(record['fields']['chapter']),
    type: type,
    feedback: record['fields']['feedback'],
  );
}
