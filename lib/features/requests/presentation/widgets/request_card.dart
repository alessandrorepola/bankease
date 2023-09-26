import 'package:bankease/features/requests/presentation/widgets/remaining_time_widget.dart';
import 'package:flutter/material.dart';
import 'package:bankease/features/requests/domain/entities/request.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RequestCard extends StatelessWidget {
  const RequestCard({
    super.key,
    required this.request,
    this.onDismissed,
    this.onTap,
  });

  final Request request;
  final DismissDirectionCallback? onDismissed;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final captionColor = theme.textTheme.bodySmall?.color;

    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 6.w),
      decoration: BoxDecoration(
        color: theme.canvasColor,
        boxShadow: [
          BoxShadow(
            color: theme.shadowColor,
            blurRadius: 8,
            offset: const Offset(0, 3),
          )
        ],
        borderRadius: BorderRadius.circular(18),
      ),
      child: Dismissible(
        key: UniqueKey(),
        onDismissed: onDismissed,
        direction: DismissDirection.endToStart,
        confirmDismiss: (DismissDirection direction) async {
          if (request.remainingTime > const Duration(minutes: 30) ||
              request.status == Status.complete) {
            return await _confirmDismissDialog(context);
          }
          return await _unableToDismissWarning(context);
        },
        background: Container(
          alignment: Alignment.centerRight,
          color: theme.colorScheme.error,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: const Icon(
            Icons.delete,
            color: Color(0xAAFFFFFF),
          ),
        ),
        child: ListTile(
          onTap: onTap,
          title: Text(
            request.service.parseString(),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: request.status != Status.complete
                ? const TextStyle(
                    fontSize: 18,
                  )
                : TextStyle(
                    fontSize: 18,
                    color: captionColor,
                    decoration: TextDecoration.lineThrough,
                  ),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              request.branch.institute,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          leading: RemainingTimeWidget(request: request),
        ),
      ),
    );
  }

  Future<bool?> _confirmDismissDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Remove Request"),
          content: const Text("Are you sure you want to remove this request?"),
          actions: <Widget>[
            ElevatedButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text("Yes")),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text("No"),
            ),
          ],
        );
      },
    );
  }

  Future<bool?> _unableToDismissWarning(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Unable To Remove Request"),
          content: const Text(
              "You cannot remove a request when there are 30 minutes left"),
          actions: <Widget>[
            ElevatedButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text("Ok")),
          ],
        );
      },
    );
  }
}
