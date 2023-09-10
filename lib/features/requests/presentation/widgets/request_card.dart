import 'package:flutter/material.dart';
import 'package:bankease/features/requests/domain/entities/request.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RequestCard extends ConsumerWidget {
  const RequestCard({Key? key, required this.request, required this.index})
      : super(key: key);
  final Request request;
  final int index;

  @override
  Widget build(BuildContext context, ref) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.w),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Color(0xff2A557934),
              blurRadius: 12,
              offset: Offset(0, 3),
            )
          ],
          borderRadius: BorderRadius.circular(8)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Column(
          children: [
            Text(request.id),
            Text(request.branch.id.toString()),
            Text(request.dt.toString()),
            Text(request.service.name),
            Text(request.state.name),
            Text(request.user.email)
          ],
        ),
      ]),
    );
  }
}
