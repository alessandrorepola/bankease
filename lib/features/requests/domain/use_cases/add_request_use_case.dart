import 'package:bankease/core/utils/utils.dart';
import 'package:bankease/features/requests/data/remote/models/request_remote_data_model.dart';
import 'package:dartz/dartz.dart';
import 'package:bankease/core/failures/failures.dart';
import 'package:bankease/core/use_case/use_case.dart';
import 'package:bankease/features/requests/domain/repositories/requests_repo.dart';

class AddRequestsUseCase
    implements FailureUseCase<RequestRemoteDataModel, AddRequestParams> {
  final RequestsRepo requestsRepo;

  AddRequestsUseCase(this.requestsRepo);

  @override
  Future<Either<Failure, RequestRemoteDataModel>> call(
      AddRequestParams params) {
    return requestsRepo.add(params);
  }
}

class AddRequestParams {
  final String service;
  final String requestDT;
  final String serviceDT;
  final String state;
  final String branchId;

  AddRequestParams(
    this.service,
    this.branchId,
    this.requestDT,
    this.serviceDT,
  ) : state = 'pending';
}
