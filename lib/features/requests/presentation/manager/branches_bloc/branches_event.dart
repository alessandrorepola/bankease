part of 'branches_bloc.dart';

sealed class BranchesEvent extends Equatable {
  @override
  List<Object> get props => [];
}

final class BranchesFetched extends BranchesEvent {}

class BranchesFilterChanged extends BranchesEvent {
  BranchesFilterChanged(this.filter);

  final String filter;

  @override
  List<Object> get props => [filter];
}

class CitySelected extends BranchesEvent {
  CitySelected(this.city);

  final String city;

  @override
  List<Object> get props => [city];
}

class BranchSelected extends BranchesEvent {
  BranchSelected(this.branch);

  final Branch branch;

  @override
  List<Object> get props => [branch];
}
