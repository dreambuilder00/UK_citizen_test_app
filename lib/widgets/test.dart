// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:red_squirrel/core/blocs/quiz/quiz_bloc.dart';
import 'package:red_squirrel/core/models/quiz_model.dart';
import 'package:red_squirrel/utils/constants/classes.dart';
import 'package:red_squirrel/utils/constants/colors.dart';
import 'package:red_squirrel/utils/functions/get_selected_answers.dart';

import 'package:red_squirrel/widgets/test_answer_button.dart';
import 'package:red_squirrel/widgets/question_label.dart';
import 'package:red_squirrel/widgets/test_binary_button.dart';
// import 'package:red_squirrel/widgets/boolean_button_compound.dart';

class Test extends StatefulWidget {
  final int index;
  final List<bool> states;
  final Function onChange;
  final Color backgroundColor;
  final Color foregroundColor;

  const Test({
    super.key,
    required this.index,
    required this.states,
    required this.onChange,
    this.backgroundColor = ThemeColors.secondary,
    this.foregroundColor = ThemeColors.progress,
  });

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  void initState() {
    super.initState();
    context.read<QuizBloc>();
  }

  @override
  Widget build(BuildContext context) {
    QuizModel quizModel = context.read<QuizBloc>().state.quiz;
    Quiz quiz = quizModel.quizzes![widget.index];
    List<String> selected = quizModel.answers![widget.index];
    int possibleAnswers =
        ([quiz.answerA, quiz.answerB]).where((item) => item.isNotEmpty).length;
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      QuestionLabel(
        question: quiz.question,
      ),
      const SizedBox(height: 40),
      if (quiz.type != 4)
        Column(
          children: [
            TestAnswerButton(
              text: quiz.optionA,
              index: 0,
              value: selected.isEmpty
                  ? widget.states[0]
                  : (selected.contains("A") ? true : false),
              onChange: (i, value) {
                setState(() {
                  if (selected.isEmpty) {
                    widget.states[i] = value;
                    if (widget.states.where((state) => state).length ==
                        possibleAnswers) {
                      widget.onChange(true, widget.states,
                          getSelectedAnswers(widget.states));
                    } else {
                      widget.onChange(false, widget.states, <String>[]);
                    }
                  }
                });
              },
            ),
            TestAnswerButton(
              text: quiz.optionB,
              index: 1,
              value: selected.isEmpty
                  ? widget.states[1]
                  : (selected.contains("B") ? true : false),
              onChange: (i, value) {
                setState(() {
                  if (selected.isEmpty) {
                    widget.states[i] = value;
                    if (widget.states.where((state) => state).length ==
                        possibleAnswers) {
                      widget.onChange(true, widget.states,
                          getSelectedAnswers(widget.states));
                    } else {
                      widget.onChange(false, widget.states, <String>[]);
                    }
                  }
                });
              },
            ),
            if (quiz.type != 3)
              TestAnswerButton(
                text: quiz.optionC,
                index: 2,
                value: selected.isEmpty
                    ? widget.states[2]
                    : (selected.contains("C") ? true : false),
                onChange: (i, value) {
                  setState(() {
                    if (selected.isEmpty) {
                      widget.states[i] = value;
                      if (widget.states.where((state) => state).length ==
                          possibleAnswers) {
                        widget.onChange(true, widget.states,
                            getSelectedAnswers(widget.states));
                      } else {
                        widget.onChange(false, widget.states, <String>[]);
                      }
                    }
                  });
                },
              ),
            if (quiz.type != 3)
              TestAnswerButton(
                text: quiz.optionD,
                index: 3,
                value: selected.isEmpty
                    ? widget.states[3]
                    : (selected.contains("D") ? true : false),
                onChange: (i, value) {
                  setState(() {
                    if (selected.isEmpty) {
                      widget.states[i] = value;
                      if (widget.states.where((state) => state).length ==
                          possibleAnswers) {
                        widget.onChange(true, widget.states,
                            getSelectedAnswers(widget.states));
                      } else {
                        widget.onChange(false, widget.states, <String>[]);
                      }
                    }
                  });
                },
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
                child: TestBinaryButton(
                    value: selected.isEmpty
                        ? (widget.states[0] == true || widget.states[1] == true)
                            ? widget.states[0]
                                ? 1
                                : 0
                            : -1
                        : (selected[0] == "A" ? 1 : 0),
                    onChange: (value) {
                      setState(() {
                        if (selected.isEmpty) {
                          if (value == 1) {
                            widget.states[0] = true;
                            widget.states[1] = false;
                          } else {
                            widget.states[0] = false;
                            widget.states[1] = true;
                          }
                          widget.onChange(
                              true, widget.states, [value == 1 ? "A" : "B"]);
                        }
                      });
                    })),
          ],
        )
    ]);
  }
}
