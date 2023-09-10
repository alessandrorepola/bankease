part of 'requests_bloc.dart';

abstract class RequestsEvent extends Equatable {
  const RequestsEvent();
}

// load
class LoadRequests extends RequestsEvent {
  @override
  List<Object> get props => [];
}
