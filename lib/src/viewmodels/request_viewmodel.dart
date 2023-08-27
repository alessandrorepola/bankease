import 'package:bankease/src/model/service_request.dart';
import 'package:bankease/src/repository/firebase_request_repository.dart';
import 'package:bankease/src/use_cases/request_use_case.dart';
import 'package:flutter/foundation.dart';

class RequestViewModel extends ChangeNotifier {
  late ServiceRequestUseCases _useCaseLayer;

  loadUserRequests(String uid) {
    _useCaseLayer = ServiceRequestUseCases(FirebaseRequestRepository(uid));
  }

  Future<void> add(ServiceRequest serviceRequest, context) async {
    _useCaseLayer.addRequest(serviceRequest);
    notifyListeners();
  }

  Future<void> delete(ServiceRequest serviceRequest) async {
    _useCaseLayer.deleteRequest(serviceRequest);
    notifyListeners();
  }

  Stream<List<ServiceRequest>> get requests => _useCaseLayer.fetchRequests();
}
