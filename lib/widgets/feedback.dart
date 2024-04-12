// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:red_squirrel/core/blocs/quiz/quiz_bloc.dart';
import 'package:red_squirrel/core/models/quiz_model.dart';
import 'package:red_squirrel/utils/constants/classes.dart';
import 'package:red_squirrel/utils/constants/colors.dart';
import 'package:red_squirrel/widgets/feedback_answer_button.dart';
import 'package:red_squirrel/widgets/feedback_binary_button.dart';

import 'package:red_squirrel/widgets/question_label.dart';

class FeedBack extends StatefulWidget {
  final int index;
  final Color backgroundColor;
  final Color foregroundColor;

  const FeedBack({
    super.key,
    required this.index,
    this.backgroundColor = ThemeColors.secondary,
    this.foregroundColor = ThemeColors.progress,
  });

  @override
  State<FeedBack> createState() => _FeedBackState();
}

class _FeedBackState extends State<FeedBack> {
  @override
  void initState() {
    super.initState();
    context.read<QuizBloc>();
  }

  @override
  Widget build(BuildContext context) {
    QuizModel quizModel = context.read<QuizBloc>().state.quiz;
    Quiz quiz = quizModel.quizzes![widget.index];
    List<String> answers =
        [quiz.answerA, quiz.answerB].where((item) => item.isNotEmpty).toList();
    List<String> selected = quizModel.answers![widget.index];
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      QuestionLabel(
        question: quiz.question,
      ),
      const SizedBox(height: 40),
      if (quiz.type != 4)
        Column(
          children: [
            FeedbackAnswerButton(
              text: quiz.optionA,
              isTrue: answers.contains("A"),
              isSelected: selected.contains("A"),
            ),
            FeedbackAnswerButton(
              text: quiz.optionB,
              isTrue: answers.contains("B"),
              isSelected: selected.contains("B"),
            ),
            if (quiz.type != 3)
              FeedbackAnswerButton(
                text: quiz.optionC,
                isTrue: answers.contains("C"),
                isSelected: selected.contains("C"),
              ),
            if (quiz.type != 3)
              FeedbackAnswerButton(
                text: quiz.optionD,
                isTrue: answers.contains("D"),
                isSelected: selected.contains("D"),
              ),
          ],
        )
      else
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const SizedBox(
              height: 100,
            ),
            SizedBox(
              child: FeedbackBinaryButton(
                  isTrue: answers.contains("A") ? true : false,
                  isSelected: selected.contains("A") ? true : false),
            ),
          ],
        )
    ]);
  }
}
