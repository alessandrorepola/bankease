import 'package:bankease/features/requests/presentation/manager/requests_bloc/requests_bloc.dart';
import 'package:bankease/features/requests/presentation/model/requests_view_filter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RequestsFilterButton extends StatelessWidget {
  const RequestsFilterButton({super.key});

  @override
  Widget build(BuildContext context) {
    final activeFilter =
        context.select((RequestsBloc bloc) => bloc.state.filter);

    return PopupMenuButton<RequestsViewFilter>(
      shape: const ContinuousRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      initialValue: activeFilter,
      tooltip: 'Filter',
      onSelected: (filter) {
        context.read<RequestsBloc>().add(RequestsFilterChanged(filter));
      },
      itemBuilder: (context) {
        return [
          const PopupMenuItem(
            value: RequestsViewFilter.all,
            child: Text('All'),
          ),
          const PopupMenuItem(
            value: RequestsViewFilter.pendingOnly,
            child: Text('Pending only'),
          ),
          const PopupMenuItem(
            value: RequestsViewFilter.completedOnly,
            child: Text('Completed only'),
          ),
        ];
      },
      icon: const Icon(Icons.filter_list_rounded),
    );
  }
}
