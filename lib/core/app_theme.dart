import 'package:flutter/material.dart';

class AppTheme {
  static get lightTheme => ThemeData(
        primarySwatch: Colors.blue,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      );
}
