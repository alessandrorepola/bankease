import 'package:bankease/features/requests/data/remote/data_sources/cities_remote_data_source.dart';
import 'package:bankease/features/requests/domain/repositories/cities_repo.dart';

class CitiesRepoImpl implements CitiesRepo {
  final CitiesRemoteDataSource _citiesRemoteDataSource;

  CitiesRepoImpl() : _citiesRemoteDataSource = CitiesRemoteDataSource();

  @override
  Future<List<String>> getSome(String startsWith) async {
    final cities = <String>[];
    final result = await _citiesRemoteDataSource.getSome(startsWith);
    for (int i = 0; i < result.length; i++) {
      cities.add(result[i].city);
    }
    return cities;
  }
}
