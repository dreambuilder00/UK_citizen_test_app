// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pressable/pressable.dart';
// import 'package:red_squirrel/components/exit_modal.dart';
import 'package:red_squirrel/utils/constants/colors.dart';
import 'package:red_squirrel/utils/constants/fonts.dart';
import 'package:red_squirrel/utils/constants/resources.dart';
import 'package:red_squirrel/utils/constants/strings.dart';
import 'package:red_squirrel/utils/constants/test_style.dart';
import 'package:red_squirrel/views/chapter_test/main_page.dart';

class ChapterTestSection extends StatelessWidget {
  const ChapterTestSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Pressable.opacity(
            onPressed: () async {
              await Navigator.of(context).push<void>(MainPage.route());
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.transparent,
                boxShadow: const [
                  BoxShadow(
                      color: Colors.grey,
                      blurRadius: 2.0, // soften the shadow
                      spreadRadius: 1.0,
                      blurStyle: BlurStyle.outer),
                ],
              ),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: ThemeColors.gradient2,
                ),
                child: Stack(children: [
                  Positioned(
                      left: 0,
                      bottom: 0,
                      width: 60,
                      height: 60,
                      child: SvgPicture.asset(
                        SvgIcons.checkList,
                        fit: BoxFit.cover,
                      )),
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Text(
                      Strings.homeChapterTest,
                      textAlign: TextAlign.center,
                      style: CustomTextStyle.SectionTitle(ThemeColors.secondary,
                          24, FontWeight.w700, Fonts.primaryFont, [
                        const Shadow(
                            color: Colors.white,
                            offset: Offset(3, 0),
                            blurRadius: 0),
                        const Shadow(
                            color: Colors.white,
                            offset: Offset(-3, 0),
                            blurRadius: 0),
                        const Shadow(
                            color: Colors.white,
                            offset: Offset(0, 2),
                            blurRadius: 0),
                        const Shadow(
                            color: Colors.white,
                            offset: Offset(0, -2),
                            blurRadius: 0)
                      ]),
                    ),
                  ),
                ]),
              ),
            )));
  }
}
