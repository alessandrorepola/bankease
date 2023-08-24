import 'package:bankease/src/model/service.dart';

class ServiceRequest{
  String? rid;
  Service? service;
  DateTime? dt;
  Branch? branch;
}

class Branch {
  String? name;
  GeoLocation? location;
}

class GeoLocation {
  int? lat;
  int? lon;
}