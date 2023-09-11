import 'package:equatable/equatable.dart';
import 'package:bankease/core/domain/entities/user_entity.dart';
import 'package:bankease/features/requests/domain/entities/branch.dart';

enum Status { pending, complete, cancelled }

enum Service { consulting, finantial, savings }

class Request extends Equatable {
  final String id;
  final UserEntity user;
  final Service service;
  final DateTime dt;
  final Status status;
  final Branch branch;

  Request({
    required this.id,
    required this.user,
    required this.service,
    required this.status,
    required this.branch,
    DateTime? dt,
  }) : dt = dt ?? DateTime.now();

  String get time =>
      'Time: ${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}:${dt.second.toString().padLeft(2, '0')}';

  String get day =>
      'Day: ${dt.year}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')}';

  Request copyWith(
      {String? id,
      UserEntity? user,
      Service? service,
      DateTime? dt,
      Status? status,
      Branch? branch}) {
    return Request(
        id: id ?? this.id,
        user: user ?? this.user,
        service: service ?? this.service,
        dt: dt ?? this.dt,
        status: status ?? this.status,
        branch: branch ?? this.branch);
  }

  // equality
  @override
  List<Object?> get props => [user, branch, dt, id];
}
