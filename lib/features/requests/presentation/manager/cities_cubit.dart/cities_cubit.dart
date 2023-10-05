import 'package:bankease/features/requests/data/repositories/cities_repo_impl.dart';
import 'package:bankease/features/requests/domain/repositories/cities_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'cities_state.dart';

class CitiesCubit extends Cubit<CitiesState> {
  CitiesCubit() : super(const CitiesState());

  final CitiesRepo _citiesRepo = CitiesRepoImpl();

  Future<void> changeFilter(String startsWith) async {
    try {
      emit(state.copyWith(status: CitiesStatus.loading));
      final cities = await _fetchCities(startsWith);
      emit(
        state.copyWith(
          filteredCities: cities,
          status: CitiesStatus.success,
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: CitiesStatus.failure));
    }
  }

  Future<List<String>> _fetchCities([String startsWith = '']) async {
    if (startsWith.length > 1) return await _citiesRepo.getSome(startsWith);
    return [];
  }
}
