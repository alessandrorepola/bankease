import 'package:bankease/src.old/model/user.dart';

abstract class UserRepository {
  Future<User?> getUser();
  loadLoggedUser(String uid);
  Future<void> createUser(
      {required String uid,
      required String username,
      required String name,
      required String surname});
  Future<void> updateUser(User user);
  Future<void> deleteUser();
}
