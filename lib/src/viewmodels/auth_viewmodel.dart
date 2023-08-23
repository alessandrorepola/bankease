import 'package:bankease/src/repository/auth_repository.dart';
import 'package:bankease/src/repository/firebase_auth_repository.dart';
import 'package:bankease/src/ui/screens/home_screen.dart';
import 'package:bankease/src/ui/screens/login_screen.dart';
import 'package:bankease/src/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthRepository _authRepository = FirebaseAuthRepository();

  Future<void> loginUser(BuildContext context,
      {required String email, required String password}) async {
    await _authRepository.loginUser(email, password).then((value) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomeScreen()));
    }).catchError((e) {
      if (e.code == "invalid-email" ||
          e.code == "wrong-password" ||
          e.code == "user-not-found") {
        Utils.snackBar("Invalid Email or Password", context);
      } else if (e.code == "too-many-requests") {
        Utils.snackBar("Too Many requests", context);
      } else if (e.code == "network-request-failed") {
        Utils.snackBar("Connection error", context);
      }
    });
  }

  Future<void> registerUser(context,
          {required String email, required String password}) async =>
      await _authRepository.registerUser(email, password).onError(
          (error, stackTrace) => Utils.snackBar("Registration error", context));

  Future<void> signOut(BuildContext context) async =>
      await _authRepository.signOut().then((value) => Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen())));

  bool isLoggedIn() {
    User? currentUser = _authRepository.currentUser;
    return currentUser != null;
  }
}
