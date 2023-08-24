import 'package:bankease/src/model/service_request.dart';

class User {
  final String uid;
  final String name;
  final String surname;
  final String username;
  final Map<String, ServiceRequest> serviceRequests;

  User({
    required this.uid,
    required this.name,
    required this.surname,
    required this.username,
    Map<String, ServiceRequest>? serviceRequests,
  }) : serviceRequests = serviceRequests ?? {};

}
