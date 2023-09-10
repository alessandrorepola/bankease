import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String name, profilePicture, email, id;

  const UserEntity({
    required this.id,
    required this.name,
    required this.profilePicture,
    required this.email,
  });

  @override
  List<Object?> get props => [id];
}
