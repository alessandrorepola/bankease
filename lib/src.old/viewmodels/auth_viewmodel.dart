import 'dart:async';

import 'package:bankease/src.old/repository/auth_repository.dart';
import 'package:bankease/src.old/repository/firebase_auth_repository.dart';
import 'package:bankease/src.old/ui/screens/home_screen.dart';
import 'package:bankease/src.old/ui/screens/login_screen.dart';
import 'package:bankease/src.old/utils/error_messages.dart';
import 'package:bankease/src.old/utils/utils.dart';
import 'package:bankease/src.old/viewmodels/user_viewmodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthRepository _authRepository = FirebaseAuthRepository();

  Future<void> loginUser(BuildContext context,
      {required String email, required String password}) async {
    await _authRepository
        .loginUser(email, password)
        .then((value) => Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const HomeScreen())))
        .catchError((e) => handleError(e.code, context));
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
      await UserViewModel()
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

  Stream<User?> get userStream => _authRepository.authStateChanges;
  String? get uid => _authRepository.currentUser?.uid;
}
