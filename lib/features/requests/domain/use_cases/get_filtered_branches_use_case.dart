import 'package:bankease/features/requests/data/repositories/branches_repo_impl.dart';
import 'package:bankease/features/requests/domain/entities/branch.dart';
import 'package:bankease/features/requests/domain/repositories/branches_repo.dart';
import 'package:bankease/core/use_case/use_case.dart';

class GetFilteredBranchesUseCase
    implements FutureUseCase<List<Branch>, String> {
  final BranchesRepo _branchesRepo = BranchesRepoImpl();

  @override
  Future<List<Branch>> call(params) async {
    final branches = await _branchesRepo.getAll();
    if (params.isEmpty) {
      return branches;
    }
    final filterdBranches = <Branch>[];
    for (var branch in branches) {
      if (branch.toString().toLowerCase().contains(params.toLowerCase())) {
        filterdBranches.add(branch);
      }
    }
    return filterdBranches;
  }
}
