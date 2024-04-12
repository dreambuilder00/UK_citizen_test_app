// ignore_for_file: library_private_types_in_public_api
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:red_squirrel/core/blocs/quiz/quiz_bloc.dart';
import 'package:red_squirrel/utils/constants/colors.dart';
import 'package:red_squirrel/utils/constants/fonts.dart';
import 'package:red_squirrel/utils/constants/resources.dart';
import 'package:red_squirrel/utils/constants/strings.dart';
import 'package:red_squirrel/utils/constants/test_style.dart';
import 'package:red_squirrel/views/full_test/test_page.dart';
// import 'package:red_squirrel/views/full_test/test_page.dart';
import 'package:red_squirrel/widgets/rounded_button.dart';

class FullTestSection extends StatefulWidget {
  const FullTestSection({
    super.key,
  });

  @override
  _FullTestSectionState createState() => _FullTestSectionState();
}

class _FullTestSectionState extends State<FullTestSection> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 24,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.transparent,
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 5.0,
              spreadRadius: 1.0,
              blurStyle: BlurStyle.outer,
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: ThemeColors.gradient1,
          ),
          child: Stack(children: [
            Positioned(
              left: 0,
              bottom: 0,
              width: 64,
              height: 64,
              child: SvgPicture.asset(
                SvgIcons.clock,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: RoundedButton(
                onPressed: () async {
                  context
                      .read<QuizBloc>()
                      .add(const QuizLoadRequested([1], 24));
                  await Navigator.of(context).push<void>(FullTestPage.route());
                },
                text: Strings.homeStartButton,
                outlined: true,
                foregroundColor: Theme.of(context).colorScheme.secondary,
              ),
            ),
            Positioned(
              top: 10,
              left: 0,
              right: 0,
              child: Text(
                Strings.homeFullTest,
                textAlign: TextAlign.center,
                style: CustomTextStyle.SectionTitle(
                  ThemeColors.secondary,
                  28,
                  FontWeight.w700,
                  Fonts.primaryFont,
                  [
                    const Shadow(
                      color: Colors.white,
                      offset: Offset(3, 0),
                      blurRadius: 0,
                    ),
                    const Shadow(
                      color: Colors.white,
                      offset: Offset(-3, 0),
                      blurRadius: 0,
                    ),
                    const Shadow(
                      color: Colors.white,
                      offset: Offset(0, 2),
                      blurRadius: 0,
                    ),
                    const Shadow(
                      color: Colors.white,
                      offset: Offset(0, -2),
                      blurRadius: 0,
                    ),
                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
