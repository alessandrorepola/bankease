import 'package:bankease/core/failures/failures.dart';
import 'package:bankease/core/injection.dart';
import 'package:bankease/core/services/local_notification_service/local_notification_service.dart';
import 'package:bankease/core/use_case/use_case.dart';
import 'package:bankease/features/requests/domain/entities/request.dart';
import 'package:bankease/features/requests/domain/repositories/requests_repo.dart';
import 'package:dartz/dartz.dart';

class UndoDeleteRequestUseCase implements FailureUseCase<Unit, Request> {
  final RequestsRepo _requestsRepo;

  UndoDeleteRequestUseCase(this._requestsRepo);

  @override
  Future<Either<Failure, Unit>> call(Request request) async {
    final result = await _requestsRepo.save(request);
    if (request.status == Status.complete) return result;

    // rischedule notification if request is pending
    result.fold(
      (l) => null,
      (r) => sl<LocalNotificationService>()
          .scheduleNotificationWhenThirtyMinutsLeftFrom(
              request.serviceDT, request.id),
    );
    return result;
  }
}
