part of 'requests_bloc.dart';

sealed class RequestsEvent extends Equatable {
  const RequestsEvent();

  @override
  List<Object> get props => [];
}

final class RequestsSubscriptionRequested extends RequestsEvent {
  const RequestsSubscriptionRequested();
}

final class RequestCompletionEvent extends RequestsEvent {
  const RequestCompletionEvent({
    required this.request,
    required this.isCompleted,
  });

  final Request request;
  final bool isCompleted;

  @override
  List<Object> get props => [request, isCompleted];
}

final class RequestDeleted extends RequestsEvent {
  const RequestDeleted(this.request);

  final Request request;

  @override
  List<Object> get props => [request];
}

final class RequestsUndoDeletionRequested extends RequestsEvent {
  const RequestsUndoDeletionRequested();
}

class RequestsFilterChanged extends RequestsEvent {
  const RequestsFilterChanged(this.filter);

  final RequestsViewFilter filter;

  @override
  List<Object> get props => [filter];
}
