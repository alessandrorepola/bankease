import 'package:bankease/src.old/model/user.dart';
import 'package:bankease/src.old/repository/user_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';

class FirebaseUserRepository implements UserRepository {
  final CollectionReference _usersColRef =
      FirebaseFirestore.instance.collection('users');
  DocumentReference? _userDocRef;

  @override
  Future<void> createUser(
      {required String uid,
      required String name,
      required String surname,
      required String username}) async {
    User user = User(name: name, surname: surname, username: username);

    _userDocRef = _usersColRef.doc(uid);
    await _userDocRef?.set(user.toJson());
  }

  @override
  Future<void> deleteUser() async {
    await _userDocRef?.delete();
  }

  Future<Map<String, dynamic>> _getUserDocument() async {
    Map<String, dynamic> data = {};
    await _userDocRef?.get().then(
      (DocumentSnapshot doc) {
        data = doc.data() as Map<String, dynamic>;
      },
      onError: (e) => Logger().e("Error getting document: $e"),
    );
    return data;
  }

  @override
  Future<User?> getUser() async {
    return User.fromJson(await _getUserDocument());
  }

  @override
  Future<void> updateUser(User user) async {
    await _userDocRef?.set(user.toJson());
  }

  @override
  loadLoggedUser(String uid) {
    _userDocRef = _usersColRef.doc(uid);
  }
}
