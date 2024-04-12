// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:red_squirrel/utils/constants/colors.dart';
import 'package:red_squirrel/utils/constants/test_style.dart';

class SubmitButton extends StatelessWidget {
  final String text;
  final bool enable;
  final Function onClick;
  final Color backgroundColor;
  final Color foregroundColor;

  const SubmitButton({
    super.key,
    required this.text,
    required this.enable,
    required this.onClick,
    this.backgroundColor = ThemeColors.label,
    this.foregroundColor = ThemeColors.primary,
  });

  @override
  Widget build(BuildContext context) {
    final ButtonStyle buttonStyle = ElevatedButton.styleFrom(
      foregroundColor: foregroundColor,
      backgroundColor: backgroundColor,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      side: BorderSide(
        color: !enable ? foregroundColor.withAlpha(80) : foregroundColor,
        width: 2,
        style: BorderStyle.solid,
      ),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(24))),
    );
    return Container(
        margin: const EdgeInsets.only(top: 5, bottom: 35),
        child: ElevatedButton(
            style: buttonStyle,
            onPressed: (enable
                ? () {
                    onClick();
                  }
                : null),
            child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 11, horizontal: 22),
                child: Text(
                  text.toUpperCase(),
                  textAlign: TextAlign.center,
                  style: CustomTextStyle.DescText(
                    !enable ? foregroundColor.withAlpha(80) : foregroundColor,
                    18,
                  ),
                ))));
  }
}
