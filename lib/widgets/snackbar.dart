import 'package:flutter/material.dart';

void showSnackBar({BuildContext? context, String? text, Color? color}) {
  ScaffoldMessenger.of(context!).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      backgroundColor: color,
      showCloseIcon: true,
      content: Text(text!),
    ),
  );
}