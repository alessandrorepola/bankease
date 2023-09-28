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
    final query = collectionWithConverter.where('userId',
        isEqualTo: _firebaseAuth.currentUser?.uid);
    return super.listen(query);
  }
}
