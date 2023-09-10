import 'package:bankease/core/firestore_crud_operations.dart';

class RequestRemoteDataModel extends FirestoreDocumentModel {
  final String service, dateTime, state, userId, branchId;

  RequestRemoteDataModel(
      {required String id,
      required this.service,
      required this.dateTime,
      required this.state,
      required this.userId,
      required this.branchId})
      : super(id);

  RequestRemoteDataModel.fromFirestoreDocument(super.doc)
      : service = doc['service'],
        dateTime = doc['dateTime'],
        state = doc['state'],
        userId = doc['userId'],
        branchId = doc['branchId'],
        super.fromFirestoreDocument();

  @override
  Map<String, dynamic> toMap() {
    return {
      'service': service,
      'dateTime': dateTime,
      'state': state,
      'userId': userId,
      'branchId': branchId
    };
  }

  RequestRemoteDataModel copyWith(
      {String? id,
      String? service,
      String? dateTime,
      String? state,
      String? userId,
      String? branchId}) {
    return RequestRemoteDataModel(
        id: id ?? this.id,
        service: service ?? this.service,
        dateTime: dateTime ?? this.dateTime,
        state: state ?? this.state,
        userId: userId ?? this.userId,
        branchId: branchId ?? this.branchId);
  }
}
