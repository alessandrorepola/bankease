import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  User? get currentUser;
  Stream<User?> get authStateChanges;
  Future<void> registerUser(String email, String password);
  Future<void> loginUser(String email, String password);
  Future<void> signOut();
}
