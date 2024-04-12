// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:red_squirrel/utils/constants/colors.dart';
import 'package:red_squirrel/utils/constants/fonts.dart';
import 'package:red_squirrel/utils/constants/resources.dart';
import 'package:red_squirrel/utils/constants/test_style.dart';

class FeedbackBinaryButton extends StatefulWidget {
  final bool isTrue;
  final bool isSelected;
  final Color backgroundColor;
  final Color foregroundColor;

  const FeedbackBinaryButton({
    super.key,
    required this.isTrue,
    required this.isSelected,
    this.backgroundColor = ThemeColors.label,
    this.foregroundColor = ThemeColors.label,
  });

  @override
  State<FeedbackBinaryButton> createState() => _FeedbackBinaryButtonState();
}

class _FeedbackBinaryButtonState extends State<FeedbackBinaryButton> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ButtonStyle trueButtonStyle = ElevatedButton.styleFrom(
      backgroundColor:
          widget.isSelected ? ThemeColors.secondary : ThemeColors.label,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      side: const BorderSide(
        color: ThemeColors.secondary,
        width: 2,
        style: BorderStyle.solid,
      ),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(100), bottomLeft: Radius.circular(100))),
    );

    final ButtonStyle falseButtonStyle = ElevatedButton.styleFrom(
      foregroundColor: widget.foregroundColor,
      backgroundColor:
          !widget.isSelected ? ThemeColors.primary : ThemeColors.label,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      side: const BorderSide(
        color: ThemeColors.primary,
        width: 2,
        style: BorderStyle.solid,
      ),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(100),
              bottomRight: Radius.circular(100))),
    );
    return Row(children: [
      const Spacer(
        flex: 1,
      ),
      Transform(
          transform: Matrix4.skewX(-0.2),
          child: ElevatedButton(
              style: trueButtonStyle,
              onPressed: () {},
              child: Container(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: Row(children: [
                    if (widget.isTrue && widget.isSelected)
                      Image.asset(
                        Images.success,
                        width: 28,
                        height: 28,
                        color: null,
                      ),
                    if (!widget.isTrue && widget.isSelected)
                      Image.asset(
                        Images.fail,
                        width: 28,
                        height: 28,
                        color: null,
                      ),
                    if (widget.isTrue && !widget.isSelected)
                      Image.asset(
                        Images.success,
                        width: 28,
                        height: 28,
                        color: null,
                      ),
                    if (!widget.isTrue && !widget.isSelected)
                      Image.asset(
                        Images.success,
                        width: 28,
                        height: 28,
                        color: const Color.fromRGBO(255, 255, 255, 0),
                      ),
                    Text(
                      'TRUE',
                      textAlign: TextAlign.center,
                      style: CustomTextStyle.SubText(
                          widget.isSelected
                              ? ThemeColors.label
                              : ThemeColors.secondary,
                          20,
                          FontWeight.w900,
                          Fonts.primaryFont,
                          [],
                          4),
                    ),
                  ])))),
      Transform(
          transform: Matrix4(
            1,
            0,
            0,
            0,
            -0.2,
            1,
            0,
            0,
            0,
            0,
            1,
            0,
            -4.5,
            10,
            0,
            1,
          ),
          child: ElevatedButton(
              style: falseButtonStyle,
              onPressed: () {},
              child: Container(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: Row(
                    children: [
                      Text(
                        'FALSE',
                        textAlign: TextAlign.center,
                        style: CustomTextStyle.SubText(
                            !widget.isSelected
                                ? ThemeColors.label
                                : ThemeColors.primary,
                            20,
                            FontWeight.w900,
                            Fonts.primaryFont,
                            [],
                            4),
                      ),
                      if (widget.isTrue && widget.isSelected)
                        Image.asset(
                          Images.success,
                          width: 28,
                          height: 28,
                          color: const Color.fromRGBO(255, 255, 255, 0),
                        ),
                      if (!widget.isTrue && widget.isSelected)
                        Image.asset(
                          Images.success,
                          width: 28,
                          height: 28,
                          color: null,
                        ),
                      if (widget.isTrue && !widget.isSelected)
                        Image.asset(
                          Images.fail,
                          width: 28,
                          height: 28,
                          color: null,
                        ),
                      if (!widget.isTrue && !widget.isSelected)
                        Image.asset(
                          Images.success,
                          width: 28,
                          height: 28,
                          color: null,
                        ),
                    ],
                  )))),
      const Spacer(
        flex: 1,
      ),
    ]);
  }
}
