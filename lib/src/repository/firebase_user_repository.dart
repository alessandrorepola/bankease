import 'package:bankease/src/model/user.dart';
import 'package:bankease/src/repository/user_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';

class FirebaseUserRepository implements UserRepository {
  final CollectionReference _usersColRef =
      FirebaseFirestore.instance.collection('users');
  DocumentReference? _userDocRef;

  @override
  Future<void> createUser(
      String uid, String name, String surname, String username) async {
    User user = User(name: name, surname: surname, username: username);

    _userDocRef = _usersColRef.doc(uid);
    await _userDocRef!.set(user.toJson());
  }

  @override
  Future<void> deleteUser() async {
    await _userDocRef?.delete();
  }

  @override
  Future<Map<String, dynamic>> getUserDocument() async {
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
    return User.fromJson(await getUserDocument());
  }

  @override
  Future<void> updateUser(
      String? username, String? name, String? surname) async {
    final oldUser = await getUser();
    final user = User(
      username: username ?? oldUser?.username,
      name: name ?? oldUser?.name,
      surname: surname ?? oldUser?.surname,
    );
    await _userDocRef?.set(user.toJson());
  }
}
