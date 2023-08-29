import 'package:bankease/src.old/model/service_request.dart';
import 'package:bankease/src.old/repository/request_repository.dart';

class ServiceRequestUseCases {
  late ServiceRequestRepository _requestRepository;

  ServiceRequestUseCases(ServiceRequestRepository repository) {
    _requestRepository = repository;
  }

  void addRequest(ServiceRequest request) {
    _requestRepository.addRequest(request);
  }

  void deleteRequest(ServiceRequest request) {
    _requestRepository.deleteRequest(request);
  }

  Stream<List<ServiceRequest>> fetchRequests() =>
      _requestRepository.getAllRequests();
}
