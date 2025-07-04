import 'package:bankease/core/app_routes.dart';
import 'package:bankease/core/injection.dart';
import 'package:bankease/features/home/widgets/home_drawer.dart';
import 'package:bankease/features/requests/presentation/manager/requests_bloc/requests_bloc.dart';
import 'package:bankease/features/requests/presentation/widgets/request_card.dart';
import 'package:bankease/features/requests/presentation/widgets/requests_filter_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../dialogs/loading_dialog.dart';

class RequestsPage extends StatelessWidget {
  const RequestsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          sl<RequestsBloc>()..add(const RequestsSubscriptionRequested()),
      child: const RequestsView(),
    );
  }
}

class RequestsView extends StatelessWidget {
  const RequestsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const HomeDrawer(),
      appBar: AppBar(
        title: const Text('Requests'),
        centerTitle: true,
        actions: const [
          RequestsFilterButton(),
        ],
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<RequestsBloc, RequestsState>(
            listenWhen: (previous, current) =>
                previous.status != current.status &&
                previous.status != RequestsStatus.initial,
            listener: (context, state) {
              if (state.status == RequestsStatus.failure) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    const SnackBar(
                      content:
                          Text('An error occurred while loading requests.'),
                    ),
                  );
              } else if (state.status == RequestsStatus.loading) {
                LoadingDialog.show(context);
              } else if (state.status == RequestsStatus.success) {
                LoadingDialog.hide(context);
              }
            },
          ),
          BlocListener<RequestsBloc, RequestsState>(
            listenWhen: (previous, current) {
              return previous.lastDeletedRequest !=
                      current.lastDeletedRequest &&
                  current.lastDeletedRequest != null;
            },
            listener: (context, state) async {
              // only when delete event is complete
              context
                  .read<RequestsBloc>()
                  .stream
                  .firstWhere((state) => state.status == RequestsStatus.success)
                  .then((value) {
                final messenger = ScaffoldMessenger.of(context);
                messenger
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(
                      duration: const Duration(seconds: 5),
                      content: const Text('Request deleted.'),
                      action: SnackBarAction(
                        label: 'Undo',
                        onPressed: () {
                          messenger.hideCurrentSnackBar();
                          context
                              .read<RequestsBloc>()
                              .add(const RequestsUndoDeletionRequested());
                        },
                      ),
                    ),
                  );
              });
            },
          ),
        ],
        child: BlocBuilder<RequestsBloc, RequestsState>(
          builder: (context, state) {
            if (state.filteredRequests.isEmpty &&
                state.status == RequestsStatus.success) {
              return Center(
                child: Text(
                  'No requests found with the selected filters.',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              );
            }
            if (state.filteredRequests.isEmpty &&
                state.status == RequestsStatus.initial) {
              return const Center(
                  child: Center(child: CircularProgressIndicator()));
            }

            return Scrollbar(
              child: ListView.separated(
                padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 5.w),
                itemBuilder: (context, index) {
                  final request = state.filteredRequests.elementAt(index);
                  return RequestCard(
                    request: request,
                    onDismissed: (_) async {
                      context.read<RequestsBloc>().add(RequestDeleted(request));
                    },
                    onTap: () {
                      Navigator.of(context).pushNamed(AppRoutes.requestDetails,
                          arguments: request);
                    },
                  );
                },
                itemCount: state.filteredRequests.length,
                separatorBuilder: (context, index) => SizedBox(
                  height: 10.h,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
