import 'package:bankease/core/failures/failures.dart';
import 'package:bankease/features/requests/domain/entities/request.dart';
import 'package:bankease/features/requests/domain/use_cases/add_request_use_case.dart';
import 'package:dartz/dartz.dart';

abstract class RequestsRepo {
  Stream<List<Request>> listenRequests();

  Future<Either<Failure, Unit>> add(AddRequestParams addRequestParams);

  Future<Either<Failure, Unit>> delete(String id);
}
