import 'package:bankease/features/requests/presentation/manager/branches_bloc/branches_bloc.dart';
import 'package:bankease/features/requests/presentation/manager/cities_cubit.dart/cities_cubit.dart';
import 'package:bankease/features/requests/presentation/widgets/branch_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import '../dialogs/branches_dialog.dart';

class BranchFields extends StatefulWidget {
  const BranchFields({super.key});

  @override
  State<BranchFields> createState() => _BranchFieldsState();
}

class _BranchFieldsState extends State<BranchFields> {
  final _scrollController = ScrollController();
  final _branchController = TextEditingController();
  final _cityController = TextEditingController();

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
    _cityController.dispose();
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
    final citiesBloc = context.watch<CitiesCubit>();
    final branchesBloc = context.watch<BranchesBloc>();

    return BlocListener<BranchesBloc, BranchesState>(
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
      child: Column(
        children: [
          SizedBox(height: 20.h),
          Container(
            height: 50.0,
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            decoration: BoxDecoration(
              border: Border.all(width: 1.0, color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: TypeAheadField(
              hideOnEmpty: true,
              hideOnLoading: true,
              hideSuggestionsOnKeyboardHide: true,
              textFieldConfiguration: TextFieldConfiguration(
                controller: _cityController,
                decoration: const InputDecoration(hintText: 'City'),
              ),
              suggestionsCallback: (pattern) async {
                await citiesBloc.changeFilter(pattern.toUpperCase());
                return citiesBloc.state.filteredCities;
              },
              itemBuilder: (context, suggestion) {
                return ListTile(title: Text(suggestion));
              },
              onSuggestionSelected: (suggestion) {
                _cityController.text = suggestion;
                branchesBloc.add(CitySelected(suggestion));
              },
            ),
          ),
          SizedBox(height: 20.h),
          Container(
            height: 50.0,
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            decoration: BoxDecoration(
              border: Border.all(width: 1.0, color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              readOnly: true,
              controller: _branchController,
              decoration: const InputDecoration(hintText: 'Branch'),
              onTap: () {
                branchesBloc.add(BranchesFetched());
                showDialog(
                  context: context,
                  builder: (_) {
                    return BlocProvider.value(
                      value: branchesBloc,
                      child: const BranchesDialog(),
                    );
                  },
                ).then((value) {
                  if (value != null) {
                    _branchController.text = value.toString();
                    branchesBloc.add(BranchSelected(value));
                  }
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Select Branch";
                } else {
                  return null;
                }
              },
            ),
          ),
          SizedBox(height: 25.h),
          BlocBuilder<BranchesBloc, BranchesState>(
            builder: (context, state) {
              return branchesBloc.state.branch != null
                  ? BranchDetails(branch: branchesBloc.state.branch!)
                  : const Center(child: Text("No Branch Selected"));
            },
          ),
        ],
      ),
    );
  }
}
