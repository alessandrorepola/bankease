import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bankease/core/injection.dart';
import 'package:bankease/features/requests/presentation/dialogs/add_request_dialog.dart';
import 'package:bankease/features/requests/presentation/manager/requests_bloc/requests_bloc.dart';
import 'package:bankease/features/requests/presentation/widgets/request_card.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RequestsPage extends StatelessWidget {
  const RequestsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RequestsBloc>(
      create: (BuildContext context) => Injection.getIt.get<RequestsBloc>(),
      child: const RequestsList(),
    );
  }
}

class RequestsList extends StatelessWidget {
  const RequestsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<RequestsBloc>().state;
    if (state is RequestsLoadInProgress) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (state is RequestsLoadSuccess) {
      final requests = state.requests;
      return Stack(
        children: [
          ListView.separated(
            padding: EdgeInsets.symmetric(vertical: 25.h, horizontal: 16.w),
            itemCount: requests.length,
            itemBuilder: (BuildContext context, int index) {
              final request = requests[index];
              return RequestCard(
                request: request,
                index: index,
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(
                height: 16.h,
              );
            },
          ),
          Positioned(
            right: 25.w,
            bottom: 80.h,
            child: FloatingActionButton(
              child: const Icon(Icons.add, color: Colors.white),
              onPressed: () {
                showDialog(
                    context: context, builder: (_) => AddRequestDialog());
              },
            ),
          )
        ],
      );
    } else {
      return const Center(
        child: Text('Error'),
      );
    }
  }
}
