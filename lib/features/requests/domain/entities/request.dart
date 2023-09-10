import 'package:equatable/equatable.dart';
import 'package:bankease/core/domain/entities/user_entity.dart';
import 'package:bankease/features/requests/domain/entities/branch.dart';

enum State { pending, complete, cancelled }

enum Service { consulting, finantial, savings }

class Request extends Equatable {
  final String id;
  final UserEntity user;
  final Service service;
  final DateTime dt;
  final State state;
  final Branch branch;

  Request({
    required this.id,
    required this.user,
    required this.service,
    required this.state,
    required this.branch,
    DateTime? dt,
  }) : dt = dt ?? DateTime.now();

  Request copyWith(
      {String? id,
      UserEntity? user,
      Service? service,
      DateTime? dt,
      State? state,
      Branch? branch}) {
    return Request(
        id: id ?? this.id,
        user: user ?? this.user,
        service: service ?? this.service,
        dt: dt ?? this.dt,
        state: state ?? this.state,
        branch: branch ?? this.branch);
  }

  // equality
  @override
  List<Object?> get props => [user, branch, dt, id];
}
