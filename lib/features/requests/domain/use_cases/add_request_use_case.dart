import 'package:bankease/features/requests/domain/entities/request.dart';
import 'package:dartz/dartz.dart';
import 'package:bankease/core/failures/failures.dart';
import 'package:bankease/core/use_case/use_case.dart';
import 'package:bankease/features/requests/domain/repositories/requests_repo.dart';

class AddRequestsUseCase implements FailureUseCase<Request, AddRequestParams> {
  final RequestsRepo _requestsRepo;

  AddRequestsUseCase(this._requestsRepo);

  @override
  Future<Either<Failure, Request>> call(AddRequestParams params) {
    return _requestsRepo.add(params);
  }
}

class AddRequestParams {
  final String service;
  final DateTime requestDT;
  final DateTime serviceDT;
  final String status;
  final String branchId;

  AddRequestParams(this.service, this.branchId, this.requestDT, this.serviceDT)
      : status = 'pending';
}
