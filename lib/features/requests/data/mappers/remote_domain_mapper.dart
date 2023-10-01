import 'package:bankease/core/domain/entities/user_entity.dart';
import 'package:bankease/features/requests/data/remote/models/request_remote_data_model.dart';
import 'package:bankease/features/requests/domain/entities/branch.dart';
import 'package:bankease/features/requests/domain/entities/request.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RemoteDomainMapper {
  static Request toDomain(
      RequestRemoteDataModel remoteData, UserEntity user, Branch branch) {
    return Request(
      id: remoteData.id,
      user: user,
      service: Service.values
          .firstWhere((element) => element.name == remoteData.service),
      status: Status.values
          .firstWhere((element) => element.name == remoteData.status),
      requestDT: remoteData.requestDT.toDate(),
      serviceDT: remoteData.serviceDT.toDate(),
      branch: branch,
    );
  }

  static RequestRemoteDataModel toRequestRemoteDataModel(Request request) {
    return RequestRemoteDataModel(
        id: request.id,
        service: request.service.name,
        requestDT: Timestamp.fromDate(request.requestDT),
        serviceDT: Timestamp.fromDate(request.serviceDT),
        status: request.status.name,
        userId: request.user.id,
        branchId: request.branch.id);
  }
}
