import 'package:equatable/equatable.dart';

class Branch extends Equatable {
  final String id, institute, address, city, postalCode, province, branch;

  const Branch({
    required this.id,
    required this.institute,
    required this.address,
    required this.city,
    required this.postalCode,
    required this.province,
    required this.branch,
  });

  @override
  List<Object?> get props => [id];

  @override
  String toString() => "$institute $address $city $province";
}
