import 'package:bankease/features/requests/data/mappers/branch_remote_domain_mapper.dart';
import 'package:bankease/features/requests/data/remote/data_sources/branches_remote_data_source.dart';
import 'package:bankease/features/requests/domain/entities/branch.dart';
import 'package:bankease/features/requests/domain/repositories/branches_repo.dart';

class BranchesRepoImpl implements BranchesRepo {
  final BranchesRemoteDataSource _branchesRemoteDataSource;

  BranchesRepoImpl() : _branchesRemoteDataSource = BranchesRemoteDataSource();

  @override
  Future<Branch?> getBranchById(String id) async {
    final branchModel = await _branchesRemoteDataSource.getOne(id);
    if (branchModel == null) return null;
    return BranchRemoteDomainMapper.toDomain(branchModel);
  }

  @override
  Future<List<Branch>> getAll() async {
    final branches = <Branch>[];
    final result = await _branchesRemoteDataSource.getAll();
    for (int i = 0; i < result.length; i++) {
      final request = BranchRemoteDomainMapper.toDomain(result[i]);
      branches.add(request);
    }
    return branches;
  }
}
