import 'package:bankease/core/use_case/use_case.dart';
import 'package:bankease/features/requests/domain/entities/request.dart';
import 'package:bankease/features/requests/domain/repositories/requests_repo.dart';

class LoadRequestsUseCase implements StreamUseCase<List<Request>, NoParams> {
  final RequestsRepo _requestsRepo;

  LoadRequestsUseCase(this._requestsRepo);

  @override
  Stream<List<Request>> call(params) {
    return _requestsRepo.getRequests();
  }
}
