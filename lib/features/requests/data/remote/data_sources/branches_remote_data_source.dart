import 'package:bankease/core/firestore_crud_operations.dart';
import 'package:bankease/features/requests/data/remote/models/branch_remote_data_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BranchesRemoteDataSource
    extends FirestoreCrudOperations<BranchRemoteDataModel> {
  BranchesRemoteDataSource()
      : super(
            'branches',
            (snapshot) =>
                BranchRemoteDataModel.fromFirestoreDocument(snapshot));

  Future<List<BranchRemoteDataModel>> getSome(String? fromId, int limit) async {
    Query<BranchRemoteDataModel> query;
    if (fromId != null) {
      query = await collectionWithConverter.doc(fromId).get().then(
          (documentSnapshot) => collectionWithConverter
              .startAfterDocument(documentSnapshot)
              .limit(limit));
    } else {
      query = collectionWithConverter.limit(limit);
    }
    return super.getAll(query);
  }
}
