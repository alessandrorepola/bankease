import 'dart:async';

import 'package:bankease/core/firestore_crud_operations.dart';
import 'package:bankease/features/requests/data/remote/models/request_remote_data_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RequestsRemoteDataSource
    extends FirestoreCrudOperations<RequestRemoteDataModel> {
  final FirebaseAuth _firebaseAuth;
  RequestsRemoteDataSource(this._firebaseAuth)
      : super(
            'requests',
            (snapshot) =>
                RequestRemoteDataModel.fromFirestoreDocument(snapshot));

  Stream<List<RequestRemoteDataModel>> listenRequests() {
    final user = _firebaseAuth.currentUser;
    final query = collectionWithConverter.where('userId', isEqualTo: user?.uid);
    final streamController = StreamController<List<RequestRemoteDataModel>>();

    super.listen(query).listen((event) {
      user != null ? streamController.add(event) : streamController.close();
    });

    return streamController.stream;
  }
}
