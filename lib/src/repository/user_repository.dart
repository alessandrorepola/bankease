import 'package:bankease/src/model/user.dart';

abstract class UserRepository {
  Future<User?> getUser();
  Future<Map<String, dynamic>> getUserDocument();
  Future<void> createUser(
      String uid, String username, String name, String surname);
  Future<void> updateUser(String username, String name, String surname);
  Future<void> deleteUser();
}
