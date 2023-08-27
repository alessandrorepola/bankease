import 'package:bankease/src/model/service_request.dart';
import 'package:bankease/src/repository/request_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseRequestRepository implements ServiceRequestRepository {
  final CollectionReference _requestsColRef;
  DocumentReference? _requestsDocRef;

  FirebaseRequestRepository(String uid)
      : _requestsColRef =
            FirebaseFirestore.instance.collection('users/$uid/serviceRequests');

  @override
  Future<void> addRequest(ServiceRequest request) async {
    _requestsDocRef = _requestsColRef.doc(request.dt.toString());
    await _requestsDocRef?.set(request.toJson());
  }

  @override
  Future<void> deleteRequest(ServiceRequest request) async {
    // TODO: implement deleteRequest
    throw UnimplementedError();
  }

  @override
  Future<List<ServiceRequest>> getAllRequests() async {
    var querySnapshot = await _requestsColRef.get();

    List<ServiceRequest> requests = [];

    for (var document in querySnapshot.docs) {
      var data = document.data() as Map<String, dynamic>;
      var request = ServiceRequest(
        username: data['username'],
        service: data['serivice'],
        dt: data['dt'],
        branch: data['branch'],
      );
      requests.add(request);
    }

    return requests;
  }
}
