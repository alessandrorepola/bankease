import 'package:bankease/core/constants/sqflite_constants.dart';
import 'package:bankease/core/sqflite.dart';
import 'package:bankease/features/requests/data/local/models/branch_local_data_model.dart';
import 'package:sqflite/sqflite.dart';

class BranchesLocalDataSource
    extends SqfLiteLocalDataSource<BranchLocalDataModel> {
  final Database database;

  BranchesLocalDataSource(this.database)
      : super(database, SqfLiteConstants.branchesTable,
            (map) => BranchLocalDataModel.fromMap(map));
}
