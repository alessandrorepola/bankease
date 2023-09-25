import 'package:bankease/core/failures/failures.dart';
import 'package:bankease/core/injection.dart';
import 'package:bankease/core/services/local_notification_service/local_notification_service.dart';
import 'package:bankease/core/use_case/use_case.dart';
import 'package:bankease/features/requests/domain/repositories/requests_repo.dart';
import 'package:dartz/dartz.dart';

class DeleteRequestUseCase implements FailureUseCase<Unit, String> {
  final RequestsRepo _requestsRepo;

  DeleteRequestUseCase(this._requestsRepo);

  @override
  Future<Either<Failure, Unit>> call(String params) async {
    final result = await _requestsRepo.delete(params);
    result.fold(
      (l) => null,
      (r) => sl<LocalNotificationService>().cancelNotification(params),
    );
    return result;
  }
}
