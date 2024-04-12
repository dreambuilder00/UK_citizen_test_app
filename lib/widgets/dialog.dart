// ignore_for_file: file_names

import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final String description;
  final Function submitAction;
  final Function cancelAction;

  const CustomDialog({
    super.key,
    required this.title,
    required this.description,
    required this.submitAction,
    required this.cancelAction,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(description),
      actions: [
        TextButton(
          onPressed: () {
            submitAction();
          },
          child: const Text('Yes'),
        ),
        TextButton(
            onPressed: () {
              cancelAction();
            },
            child: const Text("No"))
      ],
    );
  }
}
