import 'package:bankease/core/injection.dart';
import 'package:bankease/core/use_case/use_case.dart';
import 'package:bankease/features/requests/data/repositories/requests_repo_impl.dart';
import 'package:bankease/features/requests/domain/repositories/requests_repo.dart';
import 'package:bankease/features/requests/domain/use_cases/add_request_use_case.dart';
import 'package:bankease/features/requests/presentation/manager/add_request/add_request_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final addRequestProvider =
    StateNotifierProvider.autoDispose<AddRequestManager, AddRequestState>(
        (ref) {
  return AddRequestManager(AddRequestsUseCase(
    Injection.getIt.get<RequestsRepoImpl>(),
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
    final result = await _addRequestsUseCase
        .call(AddRequestParams(state.service!, state.branchId));
    result.fold((l) => null, (r) => null);
  }
}
