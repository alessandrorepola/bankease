import 'dart:developer';

import 'package:bankease/src/model/service.dart';
import 'package:bankease/src/model/service_request.dart';
import 'package:bankease/src/utils/utils.dart';
import 'package:bankease/src/viewmodels/request_viewmodel.dart';
import 'package:bankease/src/viewmodels/user_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddRequestScreen extends StatefulWidget {
  const AddRequestScreen({super.key});

  static const routeName = '/add_request';

  @override
  State<AddRequestScreen> createState() => _AddRequestScreenState();
}

class _AddRequestScreenState extends State<AddRequestScreen> {
  final _serviceController = TextEditingController();
  final _branchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add request'),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            // Campo per il tipo di servizio
            TextField(
              controller: _serviceController,
              decoration: const InputDecoration(
                labelText: 'Tipo di servizio',
              ),
            ),
            // Campo per la sede interessata
            TextField(
              controller: _branchController,
              decoration: const InputDecoration(
                labelText: 'Sede interessata',
              ),
            ),
            // Pulsante per confermare la scelta
            ElevatedButton(
              onPressed: _addRequest,
              child: const Text('Conferma'),
            ),
            // Pulsante per cancellare la scelta
            ElevatedButton(
              child: const Text('Cancella'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
    );
  }

  void _addRequest() {
    final authedUser = Provider.of<UserViewModel>(context, listen: false).user;

    if (authedUser == null) {
      Utils.snackBar("Error retrieving user info", context);
      return;
    }

    ServiceRequest request = ServiceRequest(
      username: authedUser.username,
      service: _getServiceAsEnum(
        _serviceController.text.trim().toLowerCase(),
      ),
      branch: _getBranch(
        _branchController.text.trim().toLowerCase(),
      ),
    );

    Provider.of<RequestViewModel>(
      context,
      listen: false,
    ).add(request, context);

    //debug
    inspect(Provider.of<RequestViewModel>(
      context,
      listen: false,
    ).requests);

    Navigator.of(context).pop();
  }

  Service _getServiceAsEnum(String lowerCase) {
    if (lowerCase == "consulenza") {
      return Service.consulting;
    } else if (lowerCase == "finanza") {
      return Service.finantial;
    } else {
      return Service.savings;
    }
  }

  Branch _getBranch(String lowerCase) => Branch(name: lowerCase);
}
