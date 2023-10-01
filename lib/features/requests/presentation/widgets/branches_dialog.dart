import 'package:bankease/features/requests/presentation/manager/add_request/add_request_manager.dart';
import 'package:bankease/features/requests/presentation/manager/branches_bloc/branches_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BranchesDialog extends ConsumerStatefulWidget {
  const BranchesDialog({
    super.key,
    required TextEditingController branchController,
  }) : _branchController = branchController;

  final TextEditingController _branchController;

  @override
  ConsumerState<BranchesDialog> createState() => _BranchesDialogState();
}

class _BranchesDialogState extends ConsumerState<BranchesDialog> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      context.read<BranchesBloc>().add(BranchesFetched());
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(addRequestProvider.notifier);

    return Dialog(
      child: SizedBox(
        width: double.maxFinite,
        child: BlocBuilder<BranchesBloc, BranchesState>(
          builder: (context, state) {
            return Column(
              children: [
                TextField(
                  decoration: const InputDecoration(
                    icon: Icon(Icons.search),
                    labelText: 'Search',
                  ),
                  onChanged: (value) {
                    context
                        .read<BranchesBloc>()
                        .add(BranchesFilterChanged(value));
                  },
                ),
                Expanded(
                  child: Container(
                    constraints: const BoxConstraints(maxHeight: 550),
                    child: state.filteredBranches.isEmpty
                        ? Center(
                            child: Text(
                              'No branches found',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          )
                        : ListView.builder(
                            itemBuilder: (BuildContext context, int index) {
                              if (index >= state.filteredBranches.length) {
                                if (!state.hasReachedMax) {
                                  context
                                      .read<BranchesBloc>()
                                      .add(BranchesFetched());
                                  return const SizedBox(
                                    height: 50,
                                    child: Center(
                                        child: CircularProgressIndicator()),
                                  );
                                } else {
                                  return const SizedBox.shrink();
                                }
                              }

                              return ListTile(
                                title: Text(
                                  state.filteredBranches[index].institute,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                subtitle: Text(
                                  state.filteredBranches[index].branch,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                onTap: () {
                                  widget._branchController.text =
                                      state.filteredBranches[index].toString();
                                  notifier.onChangedBranch(
                                      state.filteredBranches[index].id);
                                  Navigator.of(context).pop();
                                },
                              );
                            },
                            itemCount: state.hasReachedMax
                                ? state.filteredBranches.length
                                : state.filteredBranches.length + 1,
                            controller: _scrollController,
                          ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
