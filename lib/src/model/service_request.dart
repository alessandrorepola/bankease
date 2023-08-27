import 'package:bankease/src/model/service.dart';

class ServiceRequest {
  final String username;
  final Service service;
  final DateTime dt;
  final Branch branch;

  ServiceRequest({
    required this.username,
    required this.service,
    required this.branch,
    DateTime? dt,
  }) : dt = dt ?? DateTime.now();

  factory ServiceRequest.fromJson(Map<String, dynamic> data) {
    return ServiceRequest(
      username: data['username'],
      service: Service.values.byName(data['service']),
      dt: data['dt'],
      branch: Branch.fromJson(data['branch']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'service': service.name,
      'dt': dt,
      'branch': branch.toJson(),
    };
  }
}

class Branch {
  final String name;
  final GeoLocation? location;

  Branch({required this.name, required this.location});

  factory Branch.fromJson(Map<String, dynamic> data) {
    return Branch(
        name: data['name'], location: GeoLocation.fromJson(data['location']));
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'location': location?.toJson(),
    };
  }
}

class GeoLocation {
  final int lat;
  final int lon;

  GeoLocation({required this.lat, required this.lon});

  factory GeoLocation.fromJson(Map<String, dynamic> data) {
    return GeoLocation(lat: data['lat'], lon: data['lon']);
  }

  Map<String, dynamic> toJson() {
    return {
      'lat': lat,
      'lon': lon,
    };
  }
}
