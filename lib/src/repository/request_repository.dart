import 'package:bankease/src/model/service_request.dart';

abstract class ServiceRequestRepository {
  Future<void> addRequest(ServiceRequest request);
  Future<void> deleteRequest(ServiceRequest request);
  Stream<List<ServiceRequest>> getAllRequests();
}
