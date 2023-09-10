import 'package:bankease/core/constants/sqflite_constants.dart';
import 'package:bankease/core/sqflite.dart';

class RequestLocalDataModel extends SqfLiteLocalDataModel {
  final String service, dateTime, state, username, branchId;

  RequestLocalDataModel(
      {required this.service,
      required this.dateTime,
      required this.state,
      required this.username,
      required this.branchId,
      required String id})
      : super(id);

  RequestLocalDataModel.fromMap(Map map)
      : service = map[SqfLiteConstants.serviceTypeColumn],
        dateTime = map[SqfLiteConstants.dateTimeColumn],
        state = map[SqfLiteConstants.stateColumn],
        username = map[SqfLiteConstants.usernameColumn],
        branchId = map[SqfLiteConstants.branchIdColumn],
        super.fromMap(map);

  @override
  Map<String, dynamic> toMap() {
    return {
      SqfLiteConstants.serviceTypeColumn: service,
      SqfLiteConstants.dateTimeColumn: dateTime,
      SqfLiteConstants.stateColumn: state,
      SqfLiteConstants.usernameColumn: username,
      SqfLiteConstants.branchIdColumn: branchId,
      ...super.toMap()
    };
  }
}
