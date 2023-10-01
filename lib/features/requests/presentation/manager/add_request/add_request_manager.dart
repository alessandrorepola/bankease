import 'package:bankease/core/injection.dart';
import 'package:bankease/core/services/local_notification_service/local_notification_service.dart';
import 'package:bankease/core/utils/utils.dart';
import 'package:bankease/features/requests/domain/repositories/requests_repo.dart';
import 'package:bankease/features/requests/domain/use_cases/add_request_use_case.dart';
import 'package:bankease/features/requests/presentation/manager/add_request/add_request_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final addRequestProvider =
    StateNotifierProvider.autoDispose<AddRequestManager, AddRequestState>(
        (ref) {
  return AddRequestManager(AddRequestsUseCase(
    sl<RequestsRepo>(),
  ));
});

class AddRequestManager extends StateNotifier<AddRequestState> {
  final AddRequestsUseCase _addRequestsUseCase;

  AddRequestManager(this._addRequestsUseCase)
      : super(AddRequestState.initial());

  void onChangedService(String value) {
    state = state.copyWith(service: value);
  }

  void onChangedBranch(String value) {
    state = state.copyWith(branchId: value);
  }

  Future<void> addRequest() async {
    final requestDT = DateTime.now();
    final serviceDT = Utils.serviceScheduler(requestDT);
    final result = await _addRequestsUseCase.call(AddRequestParams(
      state.service!,
      state.branchId,
      requestDT,
      serviceDT,
    ));
    result.fold(
        (l) => null,
        (r) => sl<LocalNotificationService>()
            .scheduleNotificationWhenThirtyMinutsLeftFrom(serviceDT, r));
  }
}
