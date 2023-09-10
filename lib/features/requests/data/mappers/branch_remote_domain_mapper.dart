import 'package:bankease/features/requests/data/remote/models/branch_remote_data_model.dart';
import 'package:bankease/features/requests/domain/entities/branch.dart';

class BranchRemoteDomainMapper {
  static Branch toDomain(BranchRemoteDataModel model) {
    return Branch(
        id: model.id,
        institute: model.institute,
        address: model.address,
        city: model.city,
        postalCode: model.postalCode,
        province: model.province,
        branch: model.branch);
  }

  static BranchRemoteDataModel toRequestRemoteDataModel(Branch branch) {
    return BranchRemoteDataModel(
        id: branch.id,
        institute: branch.institute,
        address: branch.address,
        city: branch.city,
        postalCode: branch.postalCode,
        province: branch.province,
        branch: branch.branch);
  }
}
