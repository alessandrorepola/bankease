import 'package:bankease/features/requests/domain/entities/branch.dart';
import 'package:bankease/features/requests/domain/repositories/branches_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:bankease/core/failures/failures.dart';
import 'package:bankease/core/network/network_info.dart';
import 'package:bankease/features/auth/domain/repositories/auth_repo.dart';
import 'package:bankease/features/requests/data/local/data_sources/requests_local_data_source.dart';
import 'package:bankease/features/requests/data/mappers/local_domain_mapper.dart';
import 'package:bankease/features/requests/data/mappers/remote_domain_mapper.dart';
import 'package:bankease/features/requests/data/remote/data_sources/requests_remote_data_source.dart';
import 'package:bankease/features/requests/data/remote/models/request_remote_data_model.dart';
import 'package:bankease/features/requests/domain/entities/request.dart';
import 'package:bankease/features/requests/domain/repositories/requests_repo.dart';
import 'package:bankease/features/requests/domain/use_cases/add_request_use_case.dart';

class RequestsRepoImpl implements RequestsRepo {
  final RequestsRemoteDataSource _remoteDataSource;

  final AuthRepo _authRepo;
  final BranchesRepo _branchesRepo;
  final NetworkInfo _networkInfo;

  RequestsRepoImpl(this._remoteDataSource, this._networkInfo, this._authRepo,
      this._branchesRepo);

  @override
  Future<Either<Failure, Unit>> add(AddRequestParams params) async {
    try {
      if (!(await _networkInfo.isConnected)) return left(NetworkFailure());
      final docId = await _remoteDataSource.getDocumentId();
      await _remoteDataSource.add(RequestRemoteDataModel(
          id: docId,
          service: params.service,
          dateTime: params.dateTime,
          state: params.state,
          branchId: params.branchId,
          userId: _authRepo.getLoggedUser().id));
      return right(unit);
    } catch (e) {
      return left(UnexpectedFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> delete(String id) async {
    try {
      if (!(await _networkInfo.isConnected)) return left(NetworkFailure());
      await _remoteDataSource.delete(id);
      return right(unit);
    } catch (e) {
      return left(UnexpectedFailure());
    }
  }

  @override
  Stream<List<Request>> listenRequests() {
    final user = _authRepo.getLoggedUser();
    return _remoteDataSource.collectionWithConverter
        .where('userId', isEqualTo: user.id)
        .snapshots()
        .asyncMap((event) async {
      if (event.docs.isNotEmpty) {
        final requests = event.docs.map((e) async {
          final branch =
              (await _branchesRepo.getBranchById(e.data().branchId))!;
          return RemoteDomainMapper.toDomain(e.data(), user, branch);
        });
        return await Future.wait(requests.toList());
      } else {
        return [];
      }
    });
  }
}
