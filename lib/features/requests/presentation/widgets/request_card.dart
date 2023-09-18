import 'package:flutter/material.dart';
import 'package:bankease/features/requests/domain/entities/request.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RequestCard extends ConsumerWidget {
  const RequestCard(
      {Key? key,
      required this.request,
      required this.index,
      required this.onTap})
      : super(key: key);

  final Request request;
  final int index;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context, ref) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 6.w),
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                color: Color(0xff2a557934),
                blurRadius: 12,
                offset: Offset(0, 3),
              )
            ],
            borderRadius: BorderRadius.circular(8)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              children: [
                Text(request.id),
                Text(request.branch.id.toString()),
                Text(request.requestDT.toString()),
                Text(request.serviceDT.toString()),
                Text(request.service.name),
                Text(request.status.name),
                Text(request.user.email)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
