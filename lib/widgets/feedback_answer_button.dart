// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:red_squirrel/utils/constants/colors.dart';
import 'package:red_squirrel/utils/constants/resources.dart';
import 'package:red_squirrel/utils/constants/test_style.dart';

class FeedbackAnswerButton extends StatefulWidget {
  final String text;
  final bool isTrue;
  final bool isSelected;
  const FeedbackAnswerButton({
    super.key,
    required this.text,
    required this.isTrue,
    required this.isSelected,
  });

  @override
  State<FeedbackAnswerButton> createState() => _FeedbackAnswerButtonState();
}

class _FeedbackAnswerButtonState extends State<FeedbackAnswerButton> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(bottom: 15),
        child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(vertical: 26, horizontal: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                  side: BorderSide(
                    width: 2.0, // Set the desired border width here
                    color: !widget.isSelected
                        ? (widget.isTrue ? ThemeColors.success : Colors.grey)
                        : (widget.isTrue
                            ? ThemeColors.success
                            : ThemeColors
                                .primary), // Set the desired border color here
                  ),
                ),
                backgroundColor: widget.isSelected == true
                    ? ThemeColors.background
                    : ThemeColors.label,
                foregroundColor: ThemeColors.secondary,
                shadowColor: Colors.grey,
                elevation: 3.0,
                splashFactory: NoSplash.splashFactory),
            child: Stack(
              children: [
                Align(
                    alignment: Alignment.center,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Text(
                        widget.text,
                        textAlign: TextAlign.center,
                        style: CustomTextStyle.LabelText(),
                      ),
                    )),
                if (widget.isSelected)
                  Align(
                    alignment: Alignment.centerRight,
                    heightFactor: 1,
                    child: SvgPicture.asset(
                      widget.isTrue ? SvgIcons.success : SvgIcons.fail,
                      width: 24,
                      height: 24,
                    ),
                  ),
                if (!widget.isSelected && widget.isTrue)
                  Align(
                    alignment: Alignment.centerRight,
                    heightFactor: 1,
                    child: SvgPicture.asset(
                      widget.isTrue ? SvgIcons.success : SvgIcons.fail,
                      width: 24,
                      height: 24,
                    ),
                  ),
              ],
            )));
  }
}
