import 'dart:developer';

import 'package:bankease/features/requests/domain/entities/branch.dart';
import 'package:bankease/features/requests/domain/use_cases/get_filtered_branches_use_case.dart';
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
  BranchesBloc(this._getFilteredBranchesUseCase)
      : super(const BranchesState()) {
    on<BranchesFilterChanged>(_onBranchesFilterChanged);
    on<BranchesFetched>(
      _onBranchesFetched,
      transformer: throttleDroppable(throttleDuration),
    );
  }

  final GetFilteredBranchesUseCase _getFilteredBranchesUseCase;

  Future<void> _onBranchesFetched(
    BranchesFetched event,
    Emitter<BranchesState> emit,
  ) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == BranchesStatus.initial) {
        final branches = await _fetchBranches();
        return emit(
          state.copyWith(
            status: BranchesStatus.success,
            branches: branches,
            filteredBranches: branches.filter(state.filter).toList(),
            hasReachedMax: false,
          ),
        );
      }
      final branches = await _fetchBranches(state.branches.last.id);
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

  Future<List<Branch>> _fetchBranches([String? startId]) async {
    return await _getFilteredBranchesUseCase
        .call(GetBranchesParams(startId, _branchesLimit));
  }
}
