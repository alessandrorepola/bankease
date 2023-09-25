import 'package:bankease/core/injection.dart';
import 'package:bankease/features/requests/domain/entities/request.dart';
import 'package:bankease/features/requests/presentation/Utils/Ticker.dart';
import 'package:bankease/features/requests/presentation/manager/requests_bloc/requests_bloc.dart';
import 'package:flutter/material.dart';

class RemainingTimeWidget extends StatelessWidget {
  const RemainingTimeWidget({super.key, required Request request})
      : _request = request;

  final Request _request;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: const Ticker().tick(),
        builder: (context, snapshot) {
          final remainingTime = _request.remainingTime.inMinutes;
          if (remainingTime > 0) {
            return Text(remainingTime.toString());
          }
          if (_request.status == Status.pending) {
            sl<RequestsBloc>().add(
                RequestCompletionEvent(request: _request, isCompleted: true));
          }
          return const Text('Completed');
        });
  }
}
