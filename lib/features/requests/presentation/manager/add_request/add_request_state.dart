final class AddRequestState {
  final String? service;
  final String branchId;

  AddRequestState(this.service, this.branchId);

  factory AddRequestState.initial() => AddRequestState(null, '');

  AddRequestState copyWith({
    String? service,
    String? branchId,
  }) {
    return AddRequestState(service ?? this.service, branchId ?? this.branchId);
  }
}
