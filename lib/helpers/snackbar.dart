import 'package:flutter/material.dart';
import 'package:note_sphere/utils/text_style.dart';

class AppHelpers {
  static void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.deepPurpleAccent,
        content: Text(message, style: AppTextStyles.appButton),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
