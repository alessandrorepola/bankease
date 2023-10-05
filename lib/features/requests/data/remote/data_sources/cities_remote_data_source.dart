import 'package:bankease/core/firestore_crud_operations.dart';
import 'package:bankease/features/requests/data/remote/models/city_remote_data_model.dart';

class CitiesRemoteDataSource
    extends FirestoreCrudOperations<CityRemoteDataModel> {
  CitiesRemoteDataSource()
      : super('cities',
            (snapshot) => CityRemoteDataModel.fromFirestoreDocument(snapshot));

  Future<List<CityRemoteDataModel>> getSome(String startsWith) async {
    final query = collectionWithConverter
        .where('city', isGreaterThanOrEqualTo: startsWith)
        .where('city', isLessThanOrEqualTo: '$startsWith\uf8ff');
    return super.getAll(query);
  }
}
