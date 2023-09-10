import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:bankease/core/use_case/use_case.dart';
import 'package:bankease/features/requests/domain/entities/request.dart';
import 'package:bankease/features/requests/domain/use_cases/load_requests_use_case.dart';

part 'requests_event.dart';

part 'requests_state.dart';

class RequestsBloc extends Cubit<RequestsState> {
  final LoadRequestsUseCase _loadRequestsUseCase;
  late final StreamSubscription _subscription;

  RequestsBloc(this._loadRequestsUseCase) : super(RequestsInitial()) {
    emit(RequestsLoadInProgress());
    _subscribe();
  }

  _subscribe() async {
    _subscription = _loadRequestsUseCase.call(NoParams()).listen((requests) {
      emit(RequestsLoadSuccess(requests));
    }, onError: (error) => emit(const RequestsLoadFailure()));
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
