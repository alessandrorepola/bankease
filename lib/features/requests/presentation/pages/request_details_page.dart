import 'package:bankease/features/requests/domain/entities/request.dart';
import 'package:bankease/features/requests/presentation/widgets/branch_details.dart';
import 'package:bankease/features/requests/presentation/widgets/date_field.dart';
import 'package:bankease/features/requests/presentation/widgets/details_page_header.dart';
import 'package:bankease/features/requests/presentation/widgets/time_field.dart';
import 'package:flutter/material.dart';

class RequestDetailsPage extends StatelessWidget {
  const RequestDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final request = ModalRoute.of(context)!.settings.arguments as Request;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Request details"),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Header(request),
                  const SizedBox(height: 24.0),
                  const Text("Planned for"),
                  const SizedBox(height: 12.0),
                  DateField(date: request.serviceDT),
                  const SizedBox(height: 12.0),
                  TimeField(time: TimeOfDay.fromDateTime(request.serviceDT)),
                  const SizedBox(height: 24.0),
                  const Text("Request on"),
                  const SizedBox(height: 12.0),
                  DateField(date: request.requestDT),
                  const SizedBox(height: 12.0),
                  TimeField(time: TimeOfDay.fromDateTime(request.requestDT)),
                  BranchDetails(branch: request.branch),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
