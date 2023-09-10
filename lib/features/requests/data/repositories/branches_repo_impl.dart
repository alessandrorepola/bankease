import 'package:bankease/features/requests/data/local/data_sources/branches_local_data_source.dart';
import 'package:bankease/features/requests/data/mappers/branch_remote_domain_mapper.dart';
import 'package:bankease/features/requests/data/remote/data_sources/branches_remote_data_source.dart';
import 'package:bankease/features/requests/domain/entities/branch.dart';
import 'package:bankease/features/requests/domain/repositories/branches_repo.dart';
import 'package:bankease/features/requests/domain/use_cases/add_request_use_case.dart';

class BranchesRepoImpl implements BranchesRepo {
  final BranchesRemoteDataSource _branchesRemoteDataSource;

  BranchesRepoImpl() : _branchesRemoteDataSource = BranchesRemoteDataSource();

  @override
  Future<void> add(AddRequestParams addBranchParams) {
    // TODO: implement add
    throw UnimplementedError();
  }

  @override
  Future<void> delete(String id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

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
