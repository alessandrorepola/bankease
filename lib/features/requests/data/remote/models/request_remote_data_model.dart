import 'package:bankease/core/firestore_crud_operations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RequestRemoteDataModel extends FirestoreDocumentModel {
  final String service, status, userId, branchId;
  final Timestamp requestDT, serviceDT;

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
      Timestamp? requestDT,
      Timestamp? serviceDT,
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
