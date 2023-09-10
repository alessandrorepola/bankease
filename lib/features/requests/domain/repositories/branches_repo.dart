import 'package:bankease/features/requests/domain/entities/branch.dart';
import 'package:bankease/features/requests/domain/use_cases/add_request_use_case.dart';

abstract class BranchesRepo {
  Future<void> add(AddRequestParams addBranchParams);

  Future<void> delete(String id);

  Future<Branch?> getBranchById(String id);

  Future<List<Branch>> getAll();
}
