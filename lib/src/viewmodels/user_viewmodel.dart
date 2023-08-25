import 'package:bankease/src/model/user.dart';
import 'package:bankease/src/repository/firebase_user_repository.dart';
import 'package:bankease/src/repository/user_repository.dart';
import 'package:flutter/material.dart';

class UserViewModel extends ChangeNotifier {
  final UserRepository _userRepository = FirebaseUserRepository();

  Future<void> createUser(
          {required String uid,
          required String username,
          required String name,
          required String surname}) async =>
      await _userRepository.createUser(
          uid: uid, username: username, name: name, surname: surname);

  Future<void> updateUser(
          {required String username,
          required String name,
          required String surname}) async =>
      await _userRepository.updateUser(username, name, surname);

  Future<User?> getUser() async => await _userRepository.getUser();

  Future<void> deleteUser() async => await _userRepository.deleteUser();
}
