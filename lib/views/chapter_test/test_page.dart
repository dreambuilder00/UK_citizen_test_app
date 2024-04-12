// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:red_squirrel/core/blocs/quiz/quiz_bloc.dart';
import 'package:red_squirrel/core/models/quiz_model.dart';

import 'package:red_squirrel/utils/constants/colors.dart';
import 'package:red_squirrel/utils/constants/fonts.dart';
import 'package:red_squirrel/utils/constants/strings.dart';
import 'package:red_squirrel/utils/constants/resources.dart';
import 'package:red_squirrel/utils/constants/test_style.dart';
import 'package:red_squirrel/utils/functions/get_count_correct_answer.dart';
import 'package:red_squirrel/views/chapter_test/main_page.dart';
import 'package:red_squirrel/views/chapter_test/result_page.dart';
import 'package:red_squirrel/widgets/dialog.dart';
import 'package:red_squirrel/widgets/navbar.dart';
import 'package:red_squirrel/widgets/progress_bar.dart';
import 'package:red_squirrel/widgets/submit_button.dart';
import 'package:red_squirrel/widgets/test.dart';

class ChapterTestPage extends StatefulWidget {
  final int chapter;
  final int count;
  const ChapterTestPage({
    super.key,
    required this.chapter,
    required this.count,
  });

  static Page<void> page(int chapter, int count) => MaterialPage<void>(
      child: ChapterTestPage(chapter: chapter, count: count));
  static Route<void> route(int chapter, int count) => MaterialPageRoute<void>(
      builder: (_) => ChapterTestPage(chapter: chapter, count: count));

  @override
  _ChapterTestPage createState() => _ChapterTestPage();
}

class _ChapterTestPage extends State<ChapterTestPage> {
  int index = 0;
  int count = 24;
  List<bool> answerState = [false, false, false, false];
  List<String> selectedAnswers = [];
  bool enableState = false;
  String chapterTitle = "";

  void previous() {
    setState(() {
      if (index > 0) {
        index -= 1;
        answerState = [false, false, false, false];
        enableState = false;
      }
    });
  }

  void next(QuizModel quiz) {
    setState(() {
      if (index < count - 1) {
        index += 1;
        answerState = [false, false, false, false];
        enableState = false;
      } else {
        List<List<String>>? answers = quiz.answers;
        int submittedAnswerCount =
            (answers)!.where((item) => item.isNotEmpty).length;
        if (submittedAnswerCount == count) {
          int correctCount = getCountCorrectAnswer(quiz, count);
          int time = 445;
          Navigator.of(context).push<void>(ResultPage.route(
              chapterTitle, widget.chapter, correctCount, count, time));
        } else {
          Fluttertoast.showToast(
            msg: Strings.testValidation,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: ThemeColors.primary,
            textColor: Colors.white,
          );
        }
      }
    });
  }

  void backAction() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomDialog(
            title: Strings.backTitle,
            description: Strings.backDescription,
            submitAction: backSubmitAction,
            cancelAction: cancelAction);
      },
    );
  }

  void refreshAction() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomDialog(
            title: Strings.refreshTitle,
            description: Strings.refreshDescription,
            submitAction: refreshSubmitAction,
            cancelAction: cancelAction);
      },
    );
  }

  void refreshSubmitAction() {
    context.read<QuizBloc>().add(const QuizLoadRequested([1], 24));
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) => ChapterTestPage(
                chapter: widget.chapter,
                count: count,
              )),
    );
  }

  void backSubmitAction() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const MainPage()),
    );
  }

  void cancelAction() {
    Navigator.of(context).pop();
  }

  @override
  void initState() {
    super.initState();
    count = widget.count;
    context.read<QuizBloc>();
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.chapter) {
      case 2:
        chapterTitle = Strings.chapter + Strings.two;
        break;
      case 4:
        chapterTitle = Strings.chapter + Strings.four;
        break;
      case 5:
        chapterTitle = Strings.chapter + Strings.five;
        break;
      case 6:
        chapterTitle = Strings.chapter + Strings.six;
        break;
    }
    return BlocBuilder<QuizBloc, QuizState>(
      builder: (context, state) {
        if (state.status == QuizStatus.loading) {
          return Container();
        } else if (state.status == QuizStatus.success) {
          QuizModel quizModel = context.read<QuizBloc>().state.quiz;
          return Scaffold(
              backgroundColor: Theme.of(context).colorScheme.primary,
              body: Column(children: [
                Container(
                  padding: const EdgeInsets.only(bottom: 15, top: 49),
                  color: Theme.of(context).colorScheme.primary,
                  alignment: Alignment.center,
                  child: Center(
                    child: Text(
                      chapterTitle.toUpperCase(),
                      style: CustomTextStyle.SectionTitle(
                        ThemeColors.label,
                        30,
                        FontWeight.w900,
                        Fonts.primaryFont,
                        [],
                        2,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Stack(children: [
                    Container(
                      padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
                      clipBehavior: Clip.none,
                      decoration: const BoxDecoration(
                        color: ThemeColors.background,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16)),
                      ),
                      child: Stack(children: [
                        Positioned(
                            bottom: -46,
                            right: -12,
                            width: 280,
                            child: Image.asset(
                              Images.bridge,
                              fit: BoxFit.scaleDown,
                            )),
                        Column(
                          children: [
                            Row(
                              children: [
                                const Spacer(
                                  flex: 1,
                                ),
                              ],
                            ),
                            ProgressBar(
                              count: count,
                              step: index + 1,
                              caption: '$index+1 / $count',
                              next: () {
                                next(quizModel);
                              },
                              previous: () {
                                previous();
                              },
                            ),
                            SizedBox(
                              height: 26,
                            ),
                            Expanded(
                                child: SingleChildScrollView(
                                    child: Test(
                              index: index,
                              states: answerState,
                              onChange: (enable, status, answers) {
                                setState(() {
                                  enableState = enable;
                                  answerState = status;
                                  selectedAnswers = answers;
                                });
                              },
                            ))),
                            Row(
                              children: [
                                const Spacer(
                                  flex: 1,
                                ),
                                SizedBox(
                                    child: SubmitButton(
                                        enable:
                                            quizModel.answers![index].isEmpty
                                                ? enableState
                                                : false,
                                        text: Strings.submitButton,
                                        onClick: () {
                                          if (quizModel
                                              .answers![index].isEmpty) {
                                            setState(() {
                                              List<List<String>>? answers =
                                                  quizModel.answers;
                                              answers![index] = selectedAnswers;
                                              context.read<QuizBloc>().add(
                                                  QuizUpdated(
                                                      quizModel.copyWith(
                                                          answers: answers)));
                                              answerState = [
                                                false,
                                                false,
                                                false,
                                                false
                                              ];
                                              enableState = false;
                                              next(quizModel);
                                            });
                                          }
                                        })),
                                const Spacer(
                                  flex: 1,
                                )
                              ],
                            )
                          ],
                        ),
                      ]),
                    ),
                  ]),
                ),
                NavBar(
                  backAction: backAction,
                  refreshAction: refreshAction,
                ),
              ]));
        } else if (state.status == QuizStatus.empty) {
          return Text('Quiz is empty!');
        } else if (state.status == QuizStatus.failure) {
          return Text('Failed to load quiz.');
        } else {
          return Container();
        }
      },
    );
  }
}
