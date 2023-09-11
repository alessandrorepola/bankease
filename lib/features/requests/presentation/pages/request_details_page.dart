import 'package:bankease/features/requests/domain/entities/request.dart';
import 'package:flutter/material.dart';

class RequestDetailsPage extends StatelessWidget {
  const RequestDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final request = ModalRoute.of(context)!.settings.arguments as Request;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Request Details'),
      ),
      body: Center(
        child: Column(
          children: [
            Text(request.id),
            Text(request.user.name),
            Text(request.user.email),
            Text(request.service.name),
            Text(request.status.name),
            Text(request.time),
            Text(request.day),
            Text(request.branch.toString()),
          ],
        ),
      ),
    );
  }
}
