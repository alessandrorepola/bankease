import 'package:bankease/core/domain/entities/user_entity.dart';
import 'package:bankease/features/requests/data/remote/models/request_remote_data_model.dart';
import 'package:bankease/features/requests/domain/entities/branch.dart';
import 'package:bankease/features/requests/domain/entities/request.dart';

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
      dt: DateTime.tryParse(remoteData.dateTime),
      branch: branch,
    );
  }

  static RequestRemoteDataModel toRequestRemoteDataModel(Request request) {
    return RequestRemoteDataModel(
        id: request.id,
        service: request.service.name,
        dateTime: request.dt.toString(),
        status: request.status.name,
        userId: request.user.id,
        branchId: request.branch.id);
  }
}
