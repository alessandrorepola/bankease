import 'package:bankease/core/utils/utils.dart';
import 'package:equatable/equatable.dart';
import 'package:bankease/core/domain/entities/user_entity.dart';
import 'package:bankease/features/requests/domain/entities/branch.dart';

enum Status { pending, complete, cancelled }

enum Service { consulting, finantial, savings }

extension StringParsing on Service {
  String parseString() {
    switch (this) {
      case Service.consulting:
        return "Consulting";
      case Service.finantial:
        return "Finantial";
      case Service.savings:
        return "Savings";
    }
  }
}

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
      '${requestDT.hour.toString().padLeft(2, '0')}:${requestDT.minute.toString().padLeft(2, '0')}';

  String get requestDay =>
      '${requestDT.year}-${requestDT.month.toString().padLeft(2, '0')}-${requestDT.day.toString().padLeft(2, '0')}';

  String get serviceTime =>
      '${serviceDT.hour.toString().padLeft(2, '0')}:${serviceDT.minute.toString().padLeft(2, '0')}';

  String get serviceDay =>
      '${serviceDT.year}-${serviceDT.month.toString().padLeft(2, '0')}-${serviceDT.day.toString().padLeft(2, '0')}';

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
