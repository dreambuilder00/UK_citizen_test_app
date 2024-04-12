// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pressable/pressable.dart';

import 'package:red_squirrel/core/blocs/quiz/quiz_bloc.dart';
import 'package:red_squirrel/core/models/quiz_model.dart';

import 'package:red_squirrel/utils/constants/colors.dart';
import 'package:red_squirrel/utils/constants/fonts.dart';
import 'package:red_squirrel/utils/constants/strings.dart';
import 'package:red_squirrel/utils/constants/resources.dart';
import 'package:red_squirrel/utils/constants/test_style.dart';
import 'package:red_squirrel/utils/functions/array_function.dart';
import 'package:red_squirrel/utils/functions/get_count_correct_answer.dart';
import 'package:red_squirrel/views/full_test/result_page.dart';
import 'package:red_squirrel/widgets/feedback.dart';
import 'package:red_squirrel/widgets/navbar.dart';
import 'package:red_squirrel/widgets/progress_bar.dart';
import 'package:red_squirrel/widgets/submit_button.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({
    super.key,
  });

  static Page<void> page() => const MaterialPage<void>(child: FeedbackPage());
  static Route<void> route() =>
      MaterialPageRoute<void>(builder: (_) => const FeedbackPage());

  @override
  _FeedbackPage createState() => _FeedbackPage();
}

class _FeedbackPage extends State<FeedbackPage> {
  int index = 0;
  int count = 24;
  bool feedback = false;

  void previous() {
    setState(() {
      if (index > 0) {
        index -= 1;
      }
    });
  }

  void feedbackAction() {
    setState(() {
      feedback = !feedback;
    });
  }

  void next(QuizModel quiz) {
    setState(() {
      if (index < count - 1) {
        index += 1;
      } else {
        int correctCount = getCountCorrectAnswer(quiz, count);
        int time = 445;
        Navigator.of(context)
            .push<void>(ResultPage.route(correctCount, count, time));
      }
    });
  }

  @override
  void initState() {
    super.initState();
    context.read<QuizBloc>();
  }

  @override
  Widget build(BuildContext context) {
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
                      Strings.fullTestCaption.toUpperCase(),
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
                                    child: FeedBack(
                              index: index,
                            ))),
                            Row(
                              children: [
                                const Spacer(
                                  flex: 1,
                                ),
                                SizedBox(
                                    child: SubmitButton(
                                        enable: compareArrays([
                                          quizModel.quizzes![index].answerA,
                                          quizModel.quizzes![index].answerB
                                        ], quizModel.answers![index])
                                            ? false
                                            : true,
                                        text: Strings.feedbackButton,
                                        onClick: () {
                                          if (!compareArrays([
                                            quizModel.quizzes![index].answerA,
                                            quizModel.quizzes![index].answerB
                                          ], quizModel.answers![index])) {
                                            feedbackAction();
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
                    if (feedback)
                      Pressable.opacity(
                        onPressed: () {
                          feedbackAction();
                        },
                        child: Stack(
                          children: [
                            Positioned(
                              bottom: 0,
                              child: AnimatedContainer(
                                  duration: Duration(milliseconds: 100),
                                  width: MediaQuery.of(context).size.width,
                                  // height: 90,
                                  margin: const EdgeInsets.all(0),
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 20, 20, 20),
                                  decoration: BoxDecoration(
                                    gradient: feedback
                                        ? ThemeColors.gradient4
                                        : ThemeColors.gradient5,
                                  ),
                                  child: Center(
                                      child: Text(
                                    quizModel.quizzes![index].feedback,
                                    style: CustomTextStyle.SpanText(
                                        ThemeColors.label),
                                    textAlign: TextAlign.left,
                                    softWrap: true,
                                  ))),
                            )
                          ],
                        ),
                      )
                  ]),
                ),
                NavBar(
                  backAction: () {},
                  refreshAction: () {},
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
