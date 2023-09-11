import 'package:bankease/core/firestore_crud_operations.dart';

class RequestRemoteDataModel extends FirestoreDocumentModel {
  final String service, dateTime, status, userId, branchId;

  RequestRemoteDataModel(
      {required String id,
      required this.service,
      required this.dateTime,
      required this.status,
      required this.userId,
      required this.branchId})
      : super(id);

  RequestRemoteDataModel.fromFirestoreDocument(super.doc)
      : service = doc['service'],
        dateTime = doc['dateTime'],
        status = doc['status'],
        userId = doc['userId'],
        branchId = doc['branchId'],
        super.fromFirestoreDocument();

  @override
  Map<String, dynamic> toMap() {
    return {
      'service': service,
      'dateTime': dateTime,
      'status': status,
      'userId': userId,
      'branchId': branchId
    };
  }

  RequestRemoteDataModel copyWith(
      {String? id,
      String? service,
      String? dateTime,
      String? status,
      String? userId,
      String? branchId}) {
    return RequestRemoteDataModel(
        id: id ?? this.id,
        service: service ?? this.service,
        dateTime: dateTime ?? this.dateTime,
        status: status ?? this.status,
        userId: userId ?? this.userId,
        branchId: branchId ?? this.branchId);
  }
}
