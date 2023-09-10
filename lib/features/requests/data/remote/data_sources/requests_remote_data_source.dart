import 'package:bankease/core/firestore_crud_operations.dart';
import 'package:bankease/features/requests/data/remote/models/request_remote_data_model.dart';

class RequestsRemoteDataSource
    extends FirestoreCrudOperations<RequestRemoteDataModel> {
  RequestsRemoteDataSource()
      : super(
            'requests',
            (snapshot) =>
                RequestRemoteDataModel.fromFirestoreDocument(snapshot));
}
