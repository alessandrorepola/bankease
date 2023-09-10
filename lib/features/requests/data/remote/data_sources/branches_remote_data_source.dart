import 'package:bankease/core/firestore_crud_operations.dart';
import 'package:bankease/features/requests/data/remote/models/branch_remote_data_model.dart';

class BranchesRemoteDataSource
    extends FirestoreCrudOperations<BranchRemoteDataModel> {
  BranchesRemoteDataSource()
      : super(
            'branches',
            (snapshot) =>
                BranchRemoteDataModel.fromFirestoreDocument(snapshot));
}
