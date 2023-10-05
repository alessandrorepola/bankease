part of 'cities_cubit.dart';

enum CitiesStatus { initial, success, failure, loading }

final class CitiesState extends Equatable {
  const CitiesState({
    this.status = CitiesStatus.initial,
    this.filteredCities = const <String>[],
    this.city = '',
  });

  final CitiesStatus status;
  final List<String> filteredCities;
  final String city;

  CitiesState copyWith({
    CitiesStatus? status,
    List<String>? filteredCities,
    String? city,
  }) {
    return CitiesState(
      status: status ?? this.status,
      filteredCities: filteredCities ?? this.filteredCities,
      city: city ?? this.city,
    );
  }

  @override
  String toString() {
    return '''CitiesState { status: $status, filteredCities: ${filteredCities.length}}''';
  }

  @override
  List<Object> get props => [
        status,
        filteredCities,
        city,
      ];
}
