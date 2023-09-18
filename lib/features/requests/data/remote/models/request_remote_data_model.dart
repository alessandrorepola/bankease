import 'package:bankease/core/firestore_crud_operations.dart';

class RequestRemoteDataModel extends FirestoreDocumentModel {
  final String service, requestDT, serviceDT, status, userId, branchId;

  RequestRemoteDataModel(
      {required String id,
      required this.service,
      required this.requestDT,
      required this.serviceDT,
      required this.status,
      required this.userId,
      required this.branchId})
      : super(id);

  RequestRemoteDataModel.fromFirestoreDocument(super.doc)
      : service = doc['service'],
        requestDT = doc['requestDT'],
        serviceDT = doc['serviceDT'],
        status = doc['status'],
        userId = doc['userId'],
        branchId = doc['branchId'],
        super.fromFirestoreDocument();

  @override
  Map<String, dynamic> toMap() {
    return {
      'service': service,
      'requestDT': requestDT,
      'serviceDT': serviceDT,
      'status': status,
      'userId': userId,
      'branchId': branchId
    };
  }

  RequestRemoteDataModel copyWith(
      {String? id,
      String? service,
      String? requestDT,
      String? serviceDT,
      String? status,
      String? userId,
      String? branchId}) {
    return RequestRemoteDataModel(
        id: id ?? this.id,
        service: service ?? this.service,
        requestDT: requestDT ?? this.requestDT,
        serviceDT: serviceDT ?? this.serviceDT,
        status: status ?? this.status,
        userId: userId ?? this.userId,
        branchId: branchId ?? this.branchId);
  }
}
