import 'package:bankease/core/domain/entities/user_entity.dart';
import 'package:bankease/features/requests/data/local/models/request_local_data_model.dart';
import 'package:bankease/features/requests/domain/entities/branch.dart';
import 'package:bankease/features/requests/domain/entities/request.dart';

class LocalDomainMapper {
  static List<Request> toDomainList(
      List<RequestLocalDataModel> localData, UserEntity user, Branch branch) {
    return localData
        .map((e) => Request(
              id: e.id,
              user: user,
              service: Service.values
                  .firstWhere((element) => element.name == e.service),
              state:
                  State.values.firstWhere((element) => element.name == e.state),
              dt: DateTime.tryParse(e.dateTime),
              branch: branch,
            ))
        .toList();
  }

  static RequestLocalDataModel toLocalDataModel(Request request) {
    return RequestLocalDataModel(
        service: request.service.name,
        dateTime: request.dt.toString(),
        state: request.state.name,
        username: request.user.name,
        branchId: request.branch.id,
        id: request.dt.toString());
  }

  static List<RequestLocalDataModel> toLocalDataModelList(
      List<Request> localData) {
    return localData.map((e) => toLocalDataModel(e)).toList();
  }
}
