import 'package:bankease/core/constants/sqflite_constants.dart';
import 'package:bankease/core/sqflite.dart';

class RequestLocalDataModel extends SqfLiteLocalDataModel {
  final String service, requestDT, serviceDT, status, username, branchId;

  RequestLocalDataModel(
      {required this.service,
      required this.requestDT,
      required this.serviceDT,
      required this.status,
      required this.username,
      required this.branchId,
      required String id})
      : super(id);

  RequestLocalDataModel.fromMap(Map map)
      : service = map[SqfLiteConstants.serviceTypeColumn],
        requestDT = map[SqfLiteConstants.requestDTColumn],
        serviceDT = map[SqfLiteConstants.serviceDTColumn],
        status = map[SqfLiteConstants.statusColumn],
        username = map[SqfLiteConstants.usernameColumn],
        branchId = map[SqfLiteConstants.branchIdColumn],
        super.fromMap(map);

  @override
  Map<String, dynamic> toMap() {
    return {
      SqfLiteConstants.serviceTypeColumn: service,
      SqfLiteConstants.requestDTColumn: requestDT,
      SqfLiteConstants.serviceDTColumn: serviceDT,
      SqfLiteConstants.statusColumn: status,
      SqfLiteConstants.usernameColumn: username,
      SqfLiteConstants.branchIdColumn: branchId,
      ...super.toMap()
    };
  }
}
