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
    return SizedBox(
      width: 70,
      height: 70,
      child: StreamBuilder(
          stream: const Ticker().tick(),
          builder: (context, snapshot) {
            final remainingTime = _request.remainingTime.inMinutes;
            if (remainingTime > 30) {
              return TimerWidget(
                remainingTime: '$remainingTime min',
                color: Colors.orange,
              );
            }
            if (remainingTime > 0) {
              return TimerWidget(
                remainingTime: '$remainingTime min',
                color: Colors.red,
              );
            }
            if (_request.status == Status.pending) {
              sl<RequestsBloc>().add(
                  RequestCompletionEvent(request: _request, isCompleted: true));
            }
            return const TimerWidget(
                remainingTime: 'Completed', color: Colors.green);
          }),
    );
  }
}

class TimerWidget extends StatelessWidget {
  const TimerWidget({
    super.key,
    required this.remainingTime,
    required this.color,
  });

  final String remainingTime;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          color: color,
          size: 35,
          Icons.timer_outlined,
        ),
        const Spacer(),
        Text(
          remainingTime,
          style: TextStyle(color: color),
        ),
      ],
    );
  }
}
