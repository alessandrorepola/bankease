part of 'branches_bloc.dart';

enum BranchesStatus { initial, success, failure }

final class BranchesState extends Equatable {
  const BranchesState({
    this.status = BranchesStatus.initial,
    this.branches = const <Branch>[],
    this.filteredBranches = const <Branch>[],
    this.filter = '',
    this.hasReachedMax = false,
  });

  final BranchesStatus status;
  final List<Branch> branches;
  final List<Branch> filteredBranches;
  final bool hasReachedMax;
  final String filter;

  BranchesState copyWith({
    BranchesStatus? status,
    List<Branch>? branches,
    List<Branch>? filteredBranches,
    String? filter,
    bool? hasReachedMax,
  }) {
    return BranchesState(
      status: status ?? this.status,
      branches: branches ?? this.branches,
      filteredBranches: filteredBranches ?? this.filteredBranches,
      filter: filter ?? this.filter,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() {
    return '''BranchesState { status: $status, hasReachedMax: $hasReachedMax, branches: ${branches.length}, filteredBranches: ${filteredBranches.length}, filter: $filter }''';
  }

  @override
  List<Object> get props => [
        status,
        branches,
        filteredBranches,
        hasReachedMax,
        filter,
      ];
}
