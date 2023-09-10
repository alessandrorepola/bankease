import 'package:bankease/core/firestore_crud_operations.dart';

class BranchRemoteDataModel extends FirestoreDocumentModel {
  final String institute, address, city, postalCode, province, branch;

  BranchRemoteDataModel(
      {required String id,
      required this.institute,
      required this.address,
      required this.city,
      required this.postalCode,
      required this.province,
      required this.branch})
      : super(id);

  BranchRemoteDataModel.fromFirestoreDocument(super.doc)
      : institute = doc['institute'],
        address = doc['address'],
        city = doc['city'],
        postalCode = doc['postalCode'],
        province = doc['province'],
        branch = doc['branch'],
        super.fromFirestoreDocument();

  @override
  Map<String, dynamic> toMap() {
    return {
      'institute': institute,
      'address': address,
      'city': city,
      'postalCode': postalCode,
      'province': province,
      'branch': branch
    };
  }

  BranchRemoteDataModel copyWith(
      {String? id,
      String? institute,
      String? address,
      String? city,
      String? postalCode,
      String? province,
      String? branch}) {
    return BranchRemoteDataModel(
        id: id ?? this.id,
        institute: institute ?? this.institute,
        address: address ?? this.address,
        city: city ?? this.city,
        postalCode: postalCode ?? this.postalCode,
        province: province ?? this.province,
        branch: branch ?? this.branch);
  }
}
