import 'package:bankease/src/model/service_request.dart';
import 'package:bankease/src/repository/request_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseRequestRepository implements ServiceRequestRepository {
  final CollectionReference _requestsColRef;

  FirebaseRequestRepository(String uid)
      : _requestsColRef =
            FirebaseFirestore.instance.collection('users/$uid/serviceRequests');

  @override
  Future<void> addRequest(ServiceRequest request) async {
    await _requestsColRef.doc(request.dt.toString()).set(request.toJson());
  }

  @override
  Future<void> deleteRequest(ServiceRequest request) async {
    await _requestsColRef.doc(request.dt.toString()).delete();
  }

  @override
  Stream<List<ServiceRequest>> getAllRequests() async* {
    // Get the query snapshot
    QuerySnapshot snapshot = await _requestsColRef.get();

    // Convert the snapshot to a list of ServiceRequest
    List<ServiceRequest> requests = snapshot.docs
        .map((doc) =>
            ServiceRequest.fromJson(doc.data() as Map<String, dynamic>))
        .toList();

    // Emit the list of ServiceRequest
    yield requests;
    // _requestsColRef.snapshots().map((querySnapshot) {
    //   List<ServiceRequest> requests = [];

    //   for (var document in querySnapshot.docs) {
    //     var data = document.data() as Map<String, dynamic>;
    //     var request = ServiceRequest.fromJson(data);
    //     requests.add(request);
    //   }
    //   return requests;
    // });
  }
}
