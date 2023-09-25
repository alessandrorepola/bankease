part of 'requests_bloc.dart';

enum RequestsStatus { initial, loading, success, failure }

final class RequestsState extends Equatable {
  const RequestsState({
    this.status = RequestsStatus.initial,
    this.requests = const [],
    this.filter = RequestsViewFilter.all,
    this.lastDeletedRequest,
  });

  final RequestsStatus status;
  final List<Request> requests;
  final RequestsViewFilter filter;
  final Request? lastDeletedRequest;

  Iterable<Request> get filteredRequests => filter.applyAll(requests);

  RequestsState copyWith({
    RequestsStatus Function()? status,
    List<Request> Function()? requests,
    RequestsViewFilter Function()? filter,
    Request? Function()? lastDeletedRequest,
  }) {
    return RequestsState(
      status: status != null ? status() : this.status,
      requests: requests != null ? requests() : this.requests,
      filter: filter != null ? filter() : this.filter,
      lastDeletedRequest: lastDeletedRequest != null
          ? lastDeletedRequest()
          : this.lastDeletedRequest,
    );
  }

  @override
  List<Object?> get props => [
        status,
        requests,
        filter,
        lastDeletedRequest,
      ];
}
