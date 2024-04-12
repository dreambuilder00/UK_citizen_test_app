// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:red_squirrel/services/store_data.dart';
import 'package:red_squirrel/utils/constants/resources.dart';
import 'package:red_squirrel/views/home/home_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({
    super.key,
  });

  static Page<void> page() => const MaterialPage<void>(child: SplashPage());

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 10), () async {
      // await Future.dek
      await storeData();
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    });

    return SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Image.asset(
          Images.splash,
          fit: BoxFit.fill,
        ));
  }
}
