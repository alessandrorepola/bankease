import 'dart:math';

import 'package:flutter/material.dart';

class Utils {
  static double? getRandomHeight() {
    final random = Random();
    const minHeight = 300;
    const maxHeight = 550;
    const heightDifference = 100;
    final randomHeight =
        random.nextInt(maxHeight - minHeight - heightDifference + 1) +
            minHeight;
    return randomHeight.toDouble();
  }

  static void fieldFocusChange(
      BuildContext context, FocusNode current, FocusNode nextFocus) {
    current.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  static void changeFocusNode(BuildContext context,
      {required FocusNode current, required FocusNode next}) {
    current.unfocus();
    FocusScope.of(context).requestFocus(next);
  }

  static snackBar(String message, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      width: 200,
      backgroundColor: Theme.of(context).colorScheme.secondary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      behavior: SnackBarBehavior.floating,
      content: Text(message, textAlign: TextAlign.center),
    ));
  }
}
