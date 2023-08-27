import 'package:flutter/material.dart';

class Utils {
  static navigateTo(context, destination) => Navigator.push(
      context, MaterialPageRoute(builder: (context) => destination));

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
