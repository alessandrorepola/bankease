import 'dart:async';

import 'package:bankease/src/repository/auth_repository.dart';
import 'package:bankease/src/repository/firebase_auth_repository.dart';
import 'package:bankease/src/ui/screens/home_screen.dart';
import 'package:bankease/src/ui/screens/login_screen.dart';
import 'package:bankease/src/utils/error_messages.dart';
import 'package:bankease/src/utils/utils.dart';
import 'package:bankease/src/viewmodels/user_viewmodel.dart';
import 'package:flutter/material.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthRepository _authRepository = FirebaseAuthRepository();
  final UserViewModel _userViewModel = UserViewModel();

  Future<void> loginUser(BuildContext context,
      {required String email, required String password}) async {
    await _authRepository.loginUser(email, password).then((value) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomeScreen()));
    }).catchError((e) => handleError(e.code, context));
  }

  Future<void> registerUser(
    context, {
    required String email,
    required String password,
    required String username,
    required String name,
    required String surname,
  }) async {
    await _authRepository.registerUser(email, password).then((value) async {
      final uid = _authRepository.currentUser!.uid;
      await _userViewModel
          .createUser(
              uid: uid, username: username, name: name, surname: surname)
          .onError((error, stackTrace) async {
        await _authRepository.deleteUser();
        return Utils.snackBar("Error in user creation", context);
      });
    }).onError(
        (error, stackTrace) => Utils.snackBar("Registration error", context));
  }

  Future<void> signOut(BuildContext context) async =>
      _authRepository.signOut().then((value) => Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen())));

  bool isUserLoggedIn() {
    return _authRepository.currentUser != null;
  }
}
