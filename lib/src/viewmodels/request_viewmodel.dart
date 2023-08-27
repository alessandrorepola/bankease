import 'package:bankease/src/model/service_request.dart';
import 'package:bankease/src/repository/firebase_request_repository.dart';
import 'package:bankease/src/use_cases/request_use_case.dart';
import 'package:bankease/src/utils/utils.dart';
import 'package:flutter/foundation.dart';

class RequestViewModel extends ChangeNotifier {
  late final ServiceRequestUseCases _useCaseLayer;
  late final ValueNotifier<List<ServiceRequest>> _requests;

  loadUserRequests(String uid) {
    _useCaseLayer = ServiceRequestUseCases(FirebaseRequestRepository(uid));
    _requests = ValueNotifier<List<ServiceRequest>>([]);
    _initRequests();
  }

  Future<void> _initRequests() async {
    final requests = await _useCaseLayer.getObservableListOfRequests();
    _requests.value = requests;
  }

  Future<void> add(ServiceRequest serviceRequest, context) async {
    Utils.snackBar("RequestViewModel", context);
    _useCaseLayer.addRequest(serviceRequest);
    _requests.value = await _useCaseLayer.getObservableListOfRequests();
  }

  Future<void> delete(ServiceRequest serviceRequest) async {
    _useCaseLayer.deleteRequest(serviceRequest);
    _requests.value = await _useCaseLayer.getObservableListOfRequests();
  }

  ValueNotifier<List<ServiceRequest>> get requests => _requests;

  @override
  void dispose() {
    _requests.dispose();
    super.dispose();
  }
}
