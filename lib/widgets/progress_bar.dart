// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:getwidget/getwidget.dart';
import 'package:red_squirrel/utils/constants/colors.dart';
import 'package:red_squirrel/utils/constants/resources.dart';
import 'package:red_squirrel/utils/constants/test_style.dart';

class ProgressBar extends StatefulWidget {
  final int count;
  final int step;
  final Function previous;
  final Function next;
  final String caption;
  final Color backgroundColor;
  final Color foregroundColor;

  const ProgressBar({
    super.key,
    required this.step,
    required this.count,
    required this.previous,
    required this.next,
    required this.caption,
    this.backgroundColor = ThemeColors.secondary,
    this.foregroundColor = ThemeColors.progress,
  });

  @override
  State<ProgressBar> createState() => _ProgressBarState();
}

class _ProgressBarState extends State<ProgressBar> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int step = widget.step;
    int count = widget.count;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              child: IconButton(
                icon: SvgPicture.asset(
                  widget.step == 1
                      ? SvgIcons.previousDisabled
                      : SvgIcons.previous,
                  width: 24,
                  height: 24,
                ),
                onPressed: () {
                  widget.previous();
                  // Handle previous button press
                },
              ),
            ),
            const Spacer(
              flex: 1,
            ),
            Text(
              '$step / $count',
              style: CustomTextStyle.DescText(),
            ),
            const Spacer(
              flex: 1,
            ),
            SizedBox(
              child: IconButton(
                // padding: const EdgeInsets.all(0.0),
                color: Colors.red,
                icon: SvgPicture.asset(
                  widget.step == widget.count
                      ? SvgIcons.nextDisabled
                      : SvgIcons.next,
                  width: 24,
                  height: 24,
                ),
                onPressed: () {
                  widget.next(); // Handle next button press
                },
              ),
            ),
          ],
        ),
        GFProgressBar(
          percentage: widget.step / widget.count * 1.0,
          lineHeight: 8.5,
          backgroundColor: widget.foregroundColor,
          progressBarColor: widget.backgroundColor,
          animation: true,
          animationDuration: 160,
          animateFromLastPercentage: true,
        ),
      ],
    );
  }
}
