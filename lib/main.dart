import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:red_squirrel/core/blocs/quiz/quiz_bloc.dart';
import 'package:red_squirrel/core/repositories/quiz_repository.dart';
import 'package:red_squirrel/utils/constants/strings.dart';
import 'package:red_squirrel/utils/constants/theme.dart';
import 'package:red_squirrel/views/splash/splash_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  final quizRepository = QuizRepository();

  runApp(DevicePreview(
    enabled: false,
    builder: (context) => MyApp(
      quizRepository: quizRepository,
    ),
  ));
}

class MyApp extends StatelessWidget {
  final QuizRepository _quizRepository;

  const MyApp({super.key, required QuizRepository quizRepository})
      : _quizRepository = quizRepository;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<QuizBloc>(
      create: (context) => QuizBloc(quizRepository: _quizRepository),
      child: const AppView(),
    );
  }
}

class AppView extends StatelessWidget implements TickerProvider {
  const AppView({super.key});

  @override
  Ticker createTicker(TickerCallback onTick) => Ticker(onTick);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme(),
        title: Strings.appName,
        home: const SplashPage());
  }
}
