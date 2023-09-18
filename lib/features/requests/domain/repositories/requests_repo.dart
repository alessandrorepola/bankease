import 'package:bankease/core/failures/failures.dart';
import 'package:bankease/features/requests/data/remote/models/request_remote_data_model.dart';
import 'package:bankease/features/requests/domain/entities/request.dart';
import 'package:bankease/features/requests/domain/use_cases/add_request_use_case.dart';
import 'package:dartz/dartz.dart';

abstract class RequestsRepo {
  Stream<List<Request>> listenRequests();

  Future<Either<Failure, Request>> getRequestById(String id);

  Future<Either<Failure, RequestRemoteDataModel>> add(
      AddRequestParams addRequestParams);

  Future<Either<Failure, Unit>> delete(String id);
}
