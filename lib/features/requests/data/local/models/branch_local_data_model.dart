import 'package:bankease/core/constants/sqflite_constants.dart';
import 'package:bankease/core/sqflite.dart';

class BranchLocalDataModel extends SqfLiteLocalDataModel {
  final String institute, address, city, postalCode, province, branch;

  BranchLocalDataModel(
      {required this.institute,
      required this.address,
      required this.city,
      required this.postalCode,
      required this.province,
      required this.branch,
      required String id})
      : super(id);

  BranchLocalDataModel.fromMap(Map map)
      : institute = map[SqfLiteConstants.instituteColumn],
        address = map[SqfLiteConstants.addressColumn],
        city = map[SqfLiteConstants.cityColumn],
        postalCode = map[SqfLiteConstants.postalCodeColumn],
        province = map[SqfLiteConstants.provinceColumn],
        branch = map[SqfLiteConstants.branchColumn],
        super.fromMap(map);

  @override
  Map<String, dynamic> toMap() {
    return {
      SqfLiteConstants.instituteColumn: institute,
      SqfLiteConstants.addressColumn: address,
      SqfLiteConstants.cityColumn: city,
      SqfLiteConstants.postalCodeColumn: postalCode,
      SqfLiteConstants.provinceColumn: province,
      SqfLiteConstants.branchColumn: branch,
      ...super.toMap()
    };
  }
}
