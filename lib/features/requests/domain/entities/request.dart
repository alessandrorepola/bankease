import 'package:bankease/core/utils/utils.dart';
import 'package:equatable/equatable.dart';
import 'package:bankease/core/domain/entities/user_entity.dart';
import 'package:bankease/features/requests/domain/entities/branch.dart';

enum Status { pending, complete, cancelled }

extension on Status {
  int compareTo(Status other) => index.compareTo(other.index);
}

enum Service { consulting, finantial, savings }

class Request extends Equatable {
  final String id;
  final UserEntity user;
  final Service service;
  final DateTime requestDT;
  final DateTime serviceDT;
  final Status status;
  final Branch branch;

  Request({
    required this.id,
    required this.user,
    required this.service,
    required this.status,
    required this.branch,
    DateTime? requestDT,
    DateTime? serviceDT,
  })  : requestDT = requestDT ?? DateTime.now(),
        serviceDT =
            serviceDT ?? Utils.serviceScheduler(requestDT ?? DateTime.now());

  String get requestTime =>
      'Time: ${requestDT.hour.toString().padLeft(2, '0')}:${requestDT.minute.toString().padLeft(2, '0')}:${requestDT.second.toString().padLeft(2, '0')}';

  String get requestDay =>
      'Day: ${requestDT.year}-${requestDT.month.toString().padLeft(2, '0')}-${requestDT.day.toString().padLeft(2, '0')}';

  String get serviceTime =>
      'Time: ${serviceDT.hour.toString().padLeft(2, '0')}:${serviceDT.minute.toString().padLeft(2, '0')}:${serviceDT.second.toString().padLeft(2, '0')}';

  String get serviceDay =>
      'Day: ${serviceDT.year}-${serviceDT.month.toString().padLeft(2, '0')}-${serviceDT.day.toString().padLeft(2, '0')}';

  Duration get remainingTime => serviceDT.difference(DateTime.now());

  Request copyWith(
      {String? id,
      UserEntity? user,
      Service? service,
      DateTime? requestDT,
      DateTime? serviceDT,
      Status? status,
      Branch? branch}) {
    return Request(
        id: id ?? this.id,
        user: user ?? this.user,
        service: service ?? this.service,
        requestDT: requestDT ?? this.requestDT,
        serviceDT: serviceDT ?? this.serviceDT,
        status: status ?? this.status,
        branch: branch ?? this.branch);
  }

  // equality
  @override
  List<Object?> get props => [user, branch, requestDT, serviceDT, id];
}
