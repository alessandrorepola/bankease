part of 'branches_bloc.dart';

enum BranchesStatus { initial, success, failure, loading }

final class BranchesState extends Equatable {
  const BranchesState({
    this.status = BranchesStatus.initial,
    this.branches = const <Branch>[],
    this.filteredBranches = const <Branch>[],
    this.filter = '',
    this.city = '',
    this.branch,
    this.hasReachedMax = false,
  });

  final BranchesStatus status;
  final List<Branch> branches;
  final List<Branch> filteredBranches;
  final bool hasReachedMax;
  final String filter;
  final String city;
  final Branch? branch;

  BranchesState copyWith({
    BranchesStatus? status,
    List<Branch>? branches,
    List<Branch>? filteredBranches,
    String? filter,
    String? city,
    bool? hasReachedMax,
    Branch? branch,
  }) {
    return BranchesState(
      status: status ?? this.status,
      branches: branches ?? this.branches,
      filteredBranches: filteredBranches ?? this.filteredBranches,
      filter: filter ?? this.filter,
      city: city ?? this.city,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      branch: branch ?? this.branch,
    );
  }

  @override
  String toString() {
    return '''BranchesState { status: $status, hasReachedMax: $hasReachedMax, branches: ${branches.length}, filteredBranches: ${filteredBranches.length}, filter: $filter }''';
  }

  @override
  List<Object?> get props => [
        status,
        branches,
        filteredBranches,
        hasReachedMax,
        filter,
        city,
        branch,
      ];
}
