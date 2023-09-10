part of 'requests_bloc.dart';

abstract class RequestsState extends Equatable {
  const RequestsState();
}

class RequestsInitial extends RequestsState {
  @override
  List<Object> get props => [];
}

// Requests loadinginprogress
class RequestsLoadInProgress extends RequestsState {
  @override
  List<Object> get props => [];
}

class RequestsLoadSuccess extends RequestsState {
  final List<Request> requests;

  const RequestsLoadSuccess(this.requests);

  // copy with
  RequestsLoadSuccess copyWith({List<Request>? requests}) {
    return RequestsLoadSuccess(requests ?? this.requests);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      super == other &&
          other is RequestsLoadSuccess &&
          runtimeType == other.runtimeType &&
          requests == other.requests;

  @override
  int get hashCode => super.hashCode ^ requests.hashCode;

  @override
  List<Object> get props => [requests];
}

class RequestsLoadFailure extends RequestsState {
  const RequestsLoadFailure();

  @override
  List<Object> get props => [];
}
