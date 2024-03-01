import 'package:flutter/material.dart';

import '../../core/colors/colors.dart';

showSnackbar({required String message, context,required Color color}) {
  final snackbar = SnackBar(
    content: Text(
      message,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        color: ColorManager.white,
      ),
    ),
    duration: const Duration(seconds: 2),
    backgroundColor: color,
    behavior: SnackBarBehavior.floating,
  );
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(snackbar);
}
