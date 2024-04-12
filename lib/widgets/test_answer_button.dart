// ignore_for_file: file_names

import 'package:flutter/material.dart';

import 'package:red_squirrel/utils/constants/colors.dart';
import 'package:red_squirrel/utils/constants/test_style.dart';

class TestAnswerButton extends StatefulWidget {
  final String text;
  final int index;
  final bool value;
  final Function onChange;

  const TestAnswerButton({
    super.key,
    required this.text,
    required this.index,
    required this.onChange,
    required this.value,
  });

  @override
  State<TestAnswerButton> createState() => _TestAnswerButtonState();
}

class _TestAnswerButtonState extends State<TestAnswerButton> {
  @override
  void initState() {
    super.initState();
  }

  void onClick() {
    setState(() {
      widget.onChange(widget.index, !widget.value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(bottom: 15),
        child: ElevatedButton(
            onPressed: () {
              onClick();
              // Add your button logic here
            },
            style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(vertical: 26, horizontal: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                  side: const BorderSide(
                    width: 2.0, // Set the desired border width here
                    color: Colors.grey, // Set the desired border color here
                  ),
                ),
                backgroundColor:
                    widget.value ? ThemeColors.background : ThemeColors.label,
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
              ],
            )));
  }
}
