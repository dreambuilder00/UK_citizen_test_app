// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors, deprecated_member_use, duplicate_ignore, prefer_interpolation_to_compose_strings, avoid_print

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pressable/pressable.dart';
import 'package:red_squirrel/core/blocs/quiz/quiz_bloc.dart';
import 'package:red_squirrel/utils/constants/colors.dart';
import 'package:red_squirrel/utils/constants/strings.dart';
import 'package:red_squirrel/utils/constants/resources.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:red_squirrel/utils/constants/test_style.dart';
import 'package:red_squirrel/views/full_test/test_page.dart';
import 'package:red_squirrel/views/chapter_test/test_page.dart';
import 'package:red_squirrel/views/chapter_test/feedback_page.dart';
import 'package:red_squirrel/widgets/dialog.dart';

import '../home/home_page.dart';

class ResultPage extends StatefulWidget {
  final String title;
  final int chapter;
  final int correct;
  final int total;
  final int time;
  const ResultPage({
    super.key,
    required this.chapter,
    required this.title,
    required this.correct,
    required this.total,
    required this.time,
  });

  // static method to create a page with no arguments
  static Page<void> page(
          String title, int chapter, int correct, int total, int time) =>
      MaterialPage<void>(
          child: ResultPage(
              title: title,
              chapter: chapter,
              correct: correct,
              total: total,
              time: time));

  static Route<void> route(
          String title, int chapter, int correct, int total, int time) =>
      MaterialPageRoute<void>(
          builder: (_) => ResultPage(
              title: title,
              chapter: chapter,
              correct: correct,
              total: total,
              time: time));

  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> with TickerProviderStateMixin {
  // lifecycle method called when the state object is created
  bool isResultSectionVisible = false;
  late AnimationController _animationController;
  late Animation<double> _fadeInAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);
    _fadeInAnimation = Tween<double>(begin: 0, end: 1.0).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeIn));
    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        isResultSectionVisible = true;
        _animationController.forward();
      });
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  // helper method to build a button widget
  GestureDetector _buildButton(String icon, String label, int type) {
    return GestureDetector(
      onTap: () {
        switch (type) {
          case 1:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => FeedbackPage(
                        title: widget.title,
                        chapter: widget.chapter,
                        count: widget.total,
                      )),
            );
            break;
          case 2:
            context.read<QuizBloc>().add(const QuizLoadRequested([1], 24));
            Navigator.of(context).push<void>(FullTestPage.route());
            break;
          case 3:
            context.read<QuizBloc>().add(QuizLoadRequested(
                widget.chapter == 2 ? [2, 3] : [widget.chapter], 24));
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => ChapterTestPage(
                        chapter: widget.chapter,
                        count: widget.total,
                      )),
            );
            break;
          case 4:
            _showExitModalDialog(context);
            break;
          default:
            break;
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            icon,
            width: 24,
            color: ThemeColors.secondary,
          ),
          SizedBox(height: 10),
          Text(label, style: CustomTextStyle.SpanText(ThemeColors.secondary))
        ],
      ),
    );
  }

  void exitAction() {
    exit(0);
  }

  void cancelAction() {
    Navigator.of(context).pop();
  }

  _showExitModalDialog(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomDialog(
            title: Strings.exitAppTitle,
            description: Strings.exitAppDescription,
            submitAction: exitAction,
            cancelAction: cancelAction);
      },
    );
  }

  // build method for the ResultPage widget
  @override
  Widget build(BuildContext context) {
    int total = widget.total;
    int percent = (widget.correct / total * 100).toInt();
    Widget statusSection = Container(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
        child: Stack(
          children: [
            Positioned(
              left: 0,
              bottom: 0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 100,
                  ),
                  TweenAnimationBuilder(
                    tween: IntTween(begin: 0, end: widget.correct),
                    duration: Duration(milliseconds: 3000),
                    builder: (context, int value, child) => Text(
                        "$value / $total",
                        style:
                            CustomTextStyle.LabelText(ThemeColors.secondary)),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  // Visibility(
                  //   visible: isResultSectionVisible,
                  //   child:
                  Text(percent >= 75 ? "Passed" : "Failed",
                      style: CustomTextStyle.LabelText(ThemeColors.secondary)),
                  // )
                ],
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: TweenAnimationBuilder(
                  tween: IntTween(begin: 0, end: percent),
                  duration: Duration(milliseconds: 3000),
                  builder: (context, int value, child) =>
                      CircularPercentIndicator(
                        radius: 80,
                        lineWidth: 22,
                        animation: true,
                        animationDuration: 3000,
                        animateFromLastPercent: true,
                        percent: percent / 100,
                        center: Text(
                          '$value%',
                          style: CustomTextStyle.HeaderTitleText(
                              ThemeColors.secondary),
                        ),
                        progressColor: Color.lerp(ThemeColors.failedProgressbar,
                            ThemeColors.successProgressbar, value / 100),
                        backgroundColor: ThemeColors.progressBar,
                        circularStrokeCap: CircularStrokeCap.round,
                      )),
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 100,
                  ),
                  Row(
                    children: [
                      TweenAnimationBuilder(
                        tween: IntTween(begin: 0, end: widget.time ~/ 60),
                        duration: Duration(milliseconds: 3000),
                        builder: (context, int value, child) => Text("$value:",
                            style: CustomTextStyle.LabelText(
                                ThemeColors.secondary)),
                      ),
                      TweenAnimationBuilder(
                        tween: IntTween(begin: 0, end: widget.time % 60),
                        duration: Duration(milliseconds: 2000),
                        builder: (context, int value, child) => Text(
                            widget.time % 60 > 10 ? "$value" : "0$value",
                            style: CustomTextStyle.LabelText(
                                ThemeColors.secondary)),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text("Time",
                      style: CustomTextStyle.LabelText(ThemeColors.secondary)),
                ],
              ),
            )
          ],
        ));
    // );
    Widget resultSection = Visibility(
        visible: isResultSectionVisible,
        child: FadeTransition(
            opacity: _fadeInAnimation,
            child: Container(
              padding: EdgeInsets.only(top: 50),
              child: Column(
                children: [
                  Text(percent >= 75 ? "Congratulations!" : "Whoops, sorry",
                      style:
                          CustomTextStyle.SectionTitle(ThemeColors.secondary)),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    percent >= 75
                        ? "You have passed the test."
                        : "You have failed the test.",
                    style: TextStyle(
                      color: Color(0xFF012169),
                      fontSize: 24,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
            )));

    Widget buttonSection = Container(
        padding: EdgeInsetsDirectional.symmetric(vertical: 70),
        child: Stack(children: [
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            bottom: 0,
            child: Center(
              child: SvgPicture.asset(
                SvgIcons.line2,
                color: ThemeColors.secondary,
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            bottom: 0,
            child: Center(
              child: SvgPicture.asset(
                SvgIcons.line1,
                width: MediaQuery.of(context).size.width - 80,
                color: ThemeColors.secondary,
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            bottom: 0,
            child: Center(
              child: SvgPicture.asset(
                SvgIcons.rectangle,
                width: 60,
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            bottom: 0,
            child: Pressable.opacity(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage()),
                  );
                },
                child: Center(
                  child: SvgPicture.asset(
                    SvgIcons.diamond,
                    width: 36,
                    color: ThemeColors.secondary,
                  ),
                )),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildButton(SvgIcons.checkResult, "Check results", 1),
                  _buildButton(SvgIcons.numberList, "Take a Full test", 2)
                ],
              ),
              SizedBox(
                height: 60,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildButton(SvgIcons.restart, "Restart test", 3),
                  _buildButton(SvgIcons.exit, "Exit the App", 4)
                ],
              )
            ],
          ),
        ]));

    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primary,
        body: Column(children: [
          Container(
            padding: const EdgeInsets.only(bottom: 15, top: 49),
            color: Theme.of(context).colorScheme.primary,
            alignment: Alignment.center,
            child: Center(
              child: Text(widget.title.toUpperCase(),
                  style: CustomTextStyle.SectionTitle(ThemeColors.label)),
            ),
          ),
          Expanded(
            child: Stack(children: [
              Container(
                height: double.infinity,
                padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
                decoration: const BoxDecoration(
                  color: ThemeColors.background,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    statusSection,
                    resultSection,
                    buttonSection,
                  ],
                ),
              ),
            ]),
          ),
        ]));
  }
}
