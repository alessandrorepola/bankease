import 'package:bankease/src.old/utils/utils.dart';
import 'package:flutter/material.dart';

const _errorMessages = {
  "invalid-email": "Invalid Email or Password",
  "wrong-password": "Invalid Email or Password",
  "user-not-found": "Invalid Email or Password",
  "too-many-requests": "Too Many requests",
  "network-request-failed": "Connection error"
};

handleError(String errorCode, BuildContext context) {
  final errorMessage = _errorMessages[errorCode] ?? "Unexpected error";
  Utils.snackBar(errorMessage, context);
}
