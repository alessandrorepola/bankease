import 'package:bankease/core/failures/failures.dart';
import 'package:bankease/core/injection.dart';
import 'package:bankease/core/use_case/use_case.dart';
import 'package:bankease/features/requests/domain/entities/request.dart';
import 'package:bankease/features/requests/domain/repositories/requests_repo.dart';
import 'package:dartz/dartz.dart';

class GetRequestUseCase implements FailureUseCase<Request, String> {
  final RequestsRepo _requestsRepo = sl<RequestsRepo>();

  @override
  Future<Either<Failure, Request>> call(String params) {
    return _requestsRepo.getRequestById(params);
  }
}
