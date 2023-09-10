import 'package:bankease/core/constants/sqflite_constants.dart';
import 'package:bankease/core/sqflite.dart';
import 'package:bankease/features/requests/data/local/models/request_local_data_model.dart';
import 'package:sqflite/sqflite.dart';

class RequestsLocalDataSource
    extends SqfLiteLocalDataSource<RequestLocalDataModel> {
  final Database database;

  RequestsLocalDataSource(this.database)
      : super(database, SqfLiteConstants.requestsTable,
            (map) => RequestLocalDataModel.fromMap(map));
}
