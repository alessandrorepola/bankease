import 'dart:developer';

import 'package:bankease/features/requests/data/repositories/branches_repo_impl.dart';
import 'package:bankease/features/requests/domain/entities/branch.dart';
import 'package:bankease/features/requests/domain/repositories/branches_repo.dart';
import 'package:bankease/features/requests/presentation/utils/branches_view_filter.dart';
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:stream_transform/stream_transform.dart';

part 'branches_event.dart';
part 'branches_state.dart';

const _branchesLimit = 150;
const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class BranchesBloc extends Bloc<BranchesEvent, BranchesState> {
  BranchesBloc() : super(const BranchesState()) {
    on<BranchesFilterChanged>(_onBranchesFilterChanged);
    on<BranchesFetched>(
      _onBranchesFetched,
      transformer: throttleDroppable(throttleDuration),
    );
    on<CitySelected>(_onCitySelected);
    on<BranchSelected>(_onBranchSelected);
  }

  final BranchesRepo _branchesRepo = BranchesRepoImpl();

  Future<void> _onBranchesFetched(
    BranchesFetched event,
    Emitter<BranchesState> emit,
  ) async {
    log('città: ${state.city}');
    if (state.hasReachedMax) return;
    try {
      if (state.status == BranchesStatus.initial) {
        emit(state.copyWith(status: BranchesStatus.loading));
        final branches = await _fetchBranches(city: state.city);
        return emit(
          state.copyWith(
            status: BranchesStatus.success,
            branches: branches,
            filteredBranches: branches.filter(state.filter).toList(),
            hasReachedMax: false,
          ),
        );
      }
      final branches = await _fetchBranches(
          startId: state.branches.last.id, city: state.city);
      branches.isEmpty
          ? emit(state.copyWith(hasReachedMax: true))
          : emit(
              state.copyWith(
                status: BranchesStatus.success,
                branches: List.of(state.branches)..addAll(branches),
                filteredBranches: List.of(state.filteredBranches)
                  ..addAll(branches.filter(state.filter).toList()),
                hasReachedMax: false,
              ),
            );
      log(state.toString());
    } catch (_) {
      emit(state.copyWith(status: BranchesStatus.failure));
    }
  }

  Future<void> _onBranchesFilterChanged(
    BranchesFilterChanged event,
    Emitter<BranchesState> emit,
  ) async {
    if (event.filter.isEmpty) {
      return;
    }
    emit(
      state.copyWith(
        status: BranchesStatus.success,
        filteredBranches: state.branches.filter(event.filter).toList(),
        filter: event.filter,
        hasReachedMax: false,
      ),
    );
  }

  Future<List<Branch>> _fetchBranches(
      {String startId = '', String city = ''}) async {
    return await _branchesRepo.getSome(startId, city, _branchesLimit);
  }

  Future<void> _onCitySelected(
    CitySelected event,
    Emitter<BranchesState> emit,
  ) async {
    emit(state.copyWith(
      branches: [],
      filteredBranches: [],
      city: event.city,
      status: BranchesStatus.initial,
    ));
  }

  Future<void> _onBranchSelected(
    BranchSelected event,
    Emitter<BranchesState> emit,
  ) async {
    emit(state.copyWith(branch: event.branch));
  }
}
