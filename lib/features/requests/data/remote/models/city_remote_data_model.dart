import 'package:bankease/core/firestore_crud_operations.dart';

class CityRemoteDataModel extends FirestoreDocumentModel {
  final String city;

  CityRemoteDataModel({required this.city}) : super(city);

  CityRemoteDataModel.fromFirestoreDocument(super.doc)
      : city = doc['city'],
        super.fromFirestoreDocument();

  @override
  Map<String, dynamic> toMap() {
    return {
      'city': city,
    };
  }

  CityRemoteDataModel copyWith({String? city}) {
    return CityRemoteDataModel(city: city ?? this.city);
  }
}
