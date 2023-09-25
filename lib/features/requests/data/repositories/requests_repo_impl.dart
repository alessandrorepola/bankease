import 'package:bankease/features/requests/domain/repositories/branches_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:bankease/core/failures/failures.dart';
import 'package:bankease/features/auth/domain/repositories/auth_repo.dart';
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

  RequestsRepoImpl(this._remoteDataSource, this._authRepo, this._branchesRepo);

  @override
  Future<Either<Failure, RequestRemoteDataModel>> add(
      AddRequestParams params) async {
    try {
      final docId = await _remoteDataSource.getDocumentId();
      final result = await _remoteDataSource.add(RequestRemoteDataModel(
          id: docId,
          service: params.service,
          requestDT: params.requestDT,
          serviceDT: params.serviceDT,
          status: params.state,
          branchId: params.branchId,
          userId: _authRepo.getLoggedUser().id));
      return right(result);
    } catch (e) {
      return left(Failure());
    }
  }

  @override
  Future<Either<Failure, Unit>> delete(String id) async {
    try {
      await _remoteDataSource.delete(id);
      return right(unit);
    } catch (e) {
      return left(RequestNotFoundFailure());
    }
  }

  @override
  Future<Either<Failure, Request>> getRequestById(String id) async {
    RequestRemoteDataModel? requestModel = await _remoteDataSource.getOne(id);

    if (requestModel == null) {
      return left(RequestNotFoundFailure());
    }

    final branch = await _branchesRepo.getBranchById(requestModel.branchId);

    if (branch == null) {
      return left(BranchNotFoundFailure());
    }

    final userEntity = await _authRepo.getUserInfo();
    return right(RemoteDomainMapper.toDomain(requestModel, userEntity, branch));
  }

  @override
  Stream<List<Request>> getRequests() {
    return _remoteDataSource.collectionWithConverter
        .where('userId', isEqualTo: _authRepo.getLoggedUser().id)
        .snapshots()
        .asyncMap((event) async {
      if (event.docs.isEmpty) {
        return [];
      }
      final requests = await Future.wait(event.docs.map((e) async {
        final branch = await _branchesRepo.getBranchById(e.data().branchId);
        if (branch != null) {
          return RemoteDomainMapper.toDomain(
              e.data(), await _authRepo.getUserInfo(), branch);
        }
        return null;
      }));
      return requests.nonNulls.toList();
    });
  }

  @override
  Future<Either<Failure, Unit>> save(Request request) async {
    try {
      await _remoteDataSource
          .add(RemoteDomainMapper.toRequestRemoteDataModel(request));
      return right(unit);
    } catch (e) {
      return left(Failure());
    }
  }
}
