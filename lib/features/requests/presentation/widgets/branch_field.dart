import 'package:bankease/features/requests/presentation/manager/branches_bloc/branches_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'branches_dialog.dart';

class BranchField extends StatefulWidget {
  const BranchField({super.key});

  @override
  State<BranchField> createState() => _BranchFieldState();
}

class _BranchFieldState extends State<BranchField> {
  final _scrollController = ScrollController();
  final _branchController = TextEditingController();

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
    _branchController.dispose();
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
    return MultiBlocListener(
      listeners: [
        BlocListener<BranchesBloc, BranchesState>(
          listenWhen: (previous, current) => previous.status != current.status,
          listener: (context, state) {
            if (state.status == BranchesStatus.failure) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  const SnackBar(
                    content: Text('Failed to fetch branches'),
                  ),
                );
            }
          },
        ),
      ],
      child: TextFormField(
        readOnly: true,
        controller: _branchController,
        onTap: () => showDialog(
          context: context,
          builder: (_) {
            return BlocProvider.value(
              value: context.watch<BranchesBloc>(),
              child: BranchesDialog(branchController: _branchController),
            );
          },
        ),
      ),
    );
  }
}
