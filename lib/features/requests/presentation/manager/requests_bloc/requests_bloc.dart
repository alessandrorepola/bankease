import 'dart:async';

import 'package:bankease/features/requests/domain/entities/request.dart';
import 'package:bankease/features/requests/domain/repositories/requests_repo.dart';
import 'package:bankease/features/requests/domain/use_cases/delete_request_use_case.dart';
import 'package:bankease/features/requests/domain/use_cases/undo_delete_request_use_case.dart';
import 'package:bankease/features/requests/presentation/utils/requests_view_filter.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'requests_event.dart';
part 'requests_state.dart';

class RequestsBloc extends Bloc<RequestsEvent, RequestsState> {
  RequestsBloc(
    this._deleteRequestUseCase,
    this._undoDeleteRequestUseCase, {
    required RequestsRepo requestsRepo,
  })  : _requestsRepo = requestsRepo,
        super(const RequestsState()) {
    on<RequestsSubscriptionRequested>(_onSubscriptionRequested);
    on<RequestCompletionEvent>(_onRequestCompletionEvent);
    on<RequestDeleted>(_onRequestDeleted);
    on<RequestsUndoDeletionRequested>(_onUndoDeletionRequested);
    on<RequestsFilterChanged>(_onFilterChanged);
  }

  final RequestsRepo _requestsRepo;
  final DeleteRequestUseCase _deleteRequestUseCase;
  final UndoDeleteRequestUseCase _undoDeleteRequestUseCase;

  /// When [RequestsSubscriptionRequested] is added, the bloc starts by
  /// emitting a loading state. In response, the UI can then render a loading
  /// indicator.
  Future<void> _onSubscriptionRequested(
    RequestsSubscriptionRequested event,
    Emitter<RequestsState> emit,
  ) async {
    emit(state.copyWith(status: () => RequestsStatus.loading));

    // creates a subscription on the requests stream from the RequestsRepo
    await emit.forEach<List<Request>>(
      _requestsRepo.getRequests(),
      onData: (requests) => state.copyWith(
        status: () => RequestsStatus.success,
        requests: () => requests
          ..sort((a, b) => a.serviceDT.compareTo(b.serviceDT))
          ..sort((a, b) => a.status.index.compareTo(b.status.index)),
      ),
      onError: (error, __) {
        return state.copyWith(
          status: () => RequestsStatus.failure,
        );
      },
    );
  }

  Future<void> _onRequestCompletionEvent(
    RequestCompletionEvent event,
    Emitter<RequestsState> emit,
  ) async {
    final newRequest = event.request.copyWith(status: Status.complete);
    await _requestsRepo.save(newRequest);
  }

  Future<void> _onRequestDeleted(
    RequestDeleted event,
    Emitter<RequestsState> emit,
  ) async {
    emit(state.copyWith(
        lastDeletedRequest: () => event.request,
        status: () => RequestsStatus.loading));

    await _deleteRequestUseCase.call(event.request.id);
    emit(state.copyWith(status: () => RequestsStatus.success));
  }

  Future<void> _onUndoDeletionRequested(
    RequestsUndoDeletionRequested event,
    Emitter<RequestsState> emit,
  ) async {
    assert(
      state.lastDeletedRequest != null,
      'Last deleted request can not be null.',
    );

    final request = state.lastDeletedRequest!;
    emit(state.copyWith(lastDeletedRequest: () => null));
    await _undoDeleteRequestUseCase.call(request);
  }

  void _onFilterChanged(
    RequestsFilterChanged event,
    Emitter<RequestsState> emit,
  ) {
    emit(state.copyWith(filter: () => event.filter));
  }
}
