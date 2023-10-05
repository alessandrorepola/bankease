import 'package:bankease/core/failures/failures.dart';
import 'package:bankease/features/requests/domain/entities/branch.dart';

abstract class BranchesRepo {
  Future<Branch?> getBranchById(String id);

  Future<List<Branch>> getAll();

  /// Get [limit] Branch objects from [fromId] Branch
  Future<List<Branch>> getSome(String fromId, String city, int limit);
}

/// Error when a [Branch] with a given id is not found.
class BranchNotFoundFailure implements Failure {}
