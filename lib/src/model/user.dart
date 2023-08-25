import 'package:bankease/src/model/service_request.dart';

class User {
  String? name;
  String? surname;
  String? username;
  List<ServiceRequest>? serviceRequests;

  User({
    required this.name,
    required this.surname,
    required this.username,
    List<ServiceRequest>? serviceRequests,
  }) : serviceRequests = serviceRequests ?? [];

  factory User.fromJson(Map<String, dynamic> data) {
    return User(
      name: data['name'],
      surname: data['surname'],
      username: data['username'],
      serviceRequests: data['serviceRequests'] is Iterable
          ? List.from(data['serviceRequests'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (name != null) 'name': name,
      if (surname != null) 'surname': surname,
      if (username != null) 'username': username,
      if (serviceRequests != null) 'serviceRequests': serviceRequests,
    };
  }
}
