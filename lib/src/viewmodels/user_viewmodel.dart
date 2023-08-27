import 'package:bankease/src/model/user.dart';
import 'package:bankease/src/repository/firebase_user_repository.dart';
import 'package:bankease/src/repository/user_repository.dart';
import 'package:flutter/material.dart';

class UserViewModel extends ChangeNotifier {
  final UserRepository _userRepository = FirebaseUserRepository();

  User? _user;

  loadLoggedUser(String uid) async {
    _userRepository.loadLoggedUser(uid);
    _user = await _userRepository.getUser();
    notifyListeners();
  }

  Future<void> createUser(
          {required String uid,
          required String username,
          required String name,
          required String surname}) async =>
      await _userRepository.createUser(
          uid: uid, username: username, name: name, surname: surname);

  Future<void> updateUser({required User user}) async =>
      await _userRepository.updateUser(user);

  User? get user => _user;

  Future<void> deleteUser() async => await _userRepository.deleteUser();
}
