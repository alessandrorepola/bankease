import 'package:firebase_auth/firebase_auth.dart';
import 'package:bankease/core/firestore_crud_operations.dart';
import 'package:bankease/features/auth/data/exceptions.dart';
import 'package:bankease/features/auth/data/remote/model/user_remote_data_model.dart';

class UsersRemoteDataSource
    extends FirestoreCrudOperations<UserRemoteDataModel> {
  final FirebaseAuth _firebaseAuth;

  UsersRemoteDataSource(this._firebaseAuth)
      : super('users', UserRemoteDataModel.fromFirestoreDocument);

  User getLoggedUser() {
    final user = _firebaseAuth.currentUser;
    return user!;
  }

  // register
  Future<User?> register(String name, String email, String password) async {
    try {
      final result = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      final user = result.user!;
      const defaultAvatar = '';
      await Future.wait([
        user.updateDisplayName(name),
        user.updatePhotoURL(defaultAvatar),
        super.add(UserRemoteDataModel(
            id: user.uid, email: email, name: name, profilePicture: ''))
      ]);

      return result.user!;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'email-already-in-use':
          throw EmailAlreadyInUseException();
        case 'invalid-email':
          throw InvalidEmailException();
        case 'weak-password':
          throw WeakPasswordException();
      }
      rethrow;
    }
  }

  Future<User?> login(String email, String password) async {
    try {
      final result = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return result.user!;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'too-many-requests':
          throw TooManyRequestException();
        case 'user-not-found':
          throw UserNotFoundException();
        case 'wrong-password':
          throw WrongPasswordException();
        case 'invalid-email':
          throw InvalidEmailException();
        case 'user-disabled':
          throw UserDisabledException();
      }
    }
    return null;
  }

  Future<void> logout() {
    return _firebaseAuth.signOut();
  }
}
