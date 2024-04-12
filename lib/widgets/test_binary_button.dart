// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:red_squirrel/utils/constants/colors.dart';
import 'package:red_squirrel/utils/constants/fonts.dart';
import 'package:red_squirrel/utils/constants/test_style.dart';

class TestBinaryButton extends StatefulWidget {
  final int value;
  final Function onChange;
  final Color backgroundColor;
  final Color foregroundColor;

  const TestBinaryButton({
    super.key,
    required this.value,
    required this.onChange,
    this.backgroundColor = ThemeColors.label,
    this.foregroundColor = ThemeColors.label,
  });

  @override
  State<TestBinaryButton> createState() => _TestBinaryButtonState();
}

class _TestBinaryButtonState extends State<TestBinaryButton> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // print(widget.value);
    final ButtonStyle trueButtonStyle = ElevatedButton.styleFrom(
      foregroundColor: widget.backgroundColor,
      backgroundColor:
          widget.value == 1 ? ThemeColors.secondary : ThemeColors.label,
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
          widget.value == 0 ? ThemeColors.primary : ThemeColors.label,
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
              onPressed: () {
                widget.onChange(1);
              },
              child: Container(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: Row(children: [
                    Text(
                      'TRUE',
                      textAlign: TextAlign.center,
                      style: CustomTextStyle.SubText(
                          widget.value == 1
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
              onPressed: () {
                widget.onChange(0);
              },
              child: Container(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: Row(
                    children: [
                      Text(
                        'FALSE',
                        textAlign: TextAlign.center,
                        style: CustomTextStyle.SubText(
                            widget.value == 0
                                ? ThemeColors.label
                                : ThemeColors.primary,
                            20,
                            FontWeight.w900,
                            Fonts.primaryFont,
                            [],
                            4),
                      ),
                    ],
                  )))),
      const Spacer(
        flex: 1,
      ),
    ]);
  }
}
