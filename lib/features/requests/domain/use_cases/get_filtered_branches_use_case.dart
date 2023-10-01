import 'package:bankease/features/requests/data/repositories/branches_repo_impl.dart';
import 'package:bankease/features/requests/domain/entities/branch.dart';
import 'package:bankease/features/requests/domain/repositories/branches_repo.dart';
import 'package:bankease/core/use_case/use_case.dart';

class GetFilteredBranchesUseCase
    implements FutureUseCase<List<Branch>, GetBranchesParams> {
  final BranchesRepo _branchesRepo = BranchesRepoImpl();

  @override
  Future<List<Branch>> call(params) async {
    return await _branchesRepo.getSome(params.startId, params.branchesLimit);
  }
}

class GetBranchesParams {
  final String? startId;
  final int branchesLimit;

  GetBranchesParams(
    this.startId,
    this.branchesLimit,
  );
}
