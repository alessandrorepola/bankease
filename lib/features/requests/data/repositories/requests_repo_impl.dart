import 'package:bankease/features/requests/domain/repositories/branches_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  Future<Either<Failure, Request>> add(AddRequestParams params) async {
    try {
      final id = await _remoteDataSource.newId();
      final result = await _remoteDataSource.add(RequestRemoteDataModel(
          id: id,
          service: params.service,
          requestDT: Timestamp.fromDate(params.requestDT),
          serviceDT: Timestamp.fromDate(params.serviceDT),
          status: params.status,
          branchId: params.branchId,
          userId: _authRepo.getLoggedUser().id));
      return right(
        RemoteDomainMapper.toDomain(
          result,
          await _authRepo.getUserInfo(),
          (await _branchesRepo.getBranchById(result.branchId))!,
        ),
      );
    } catch (e) {
      return left(Failure());
    }
  }

  @override
  Future<Either<Failure, Unit>> save(Request request) async {
    try {
      await _remoteDataSource.add(RequestRemoteDataModel(
          id: request.id,
          service: request.service.name,
          requestDT: Timestamp.fromDate(request.requestDT),
          serviceDT: Timestamp.fromDate(request.serviceDT),
          status: request.status.name,
          branchId: request.branch.id,
          userId: request.user.id));
      return right(unit);
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
    return _remoteDataSource.listenRequests().asyncMap((list) async {
      final List<Request> requests = <Request>[];
      for (var remoteData in list) {
        var branch = await _branchesRepo.getBranchById(remoteData.branchId);
        if (branch != null) {
          requests.add(RemoteDomainMapper.toDomain(
              remoteData, await _authRepo.getUserInfo(), branch));
        }
      }
      return requests;
    });
  }
}
