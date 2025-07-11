import 'package:dartz/dartz.dart';
import 'package:bankease/core/domain/entities/user_entity.dart';
import 'package:bankease/core/failures/failures.dart';
import 'package:bankease/core/value_objects/email_value_object.dart';
import 'package:bankease/core/value_objects/password_value_object.dart';
import 'package:bankease/features/auth/data/exceptions.dart';
import 'package:bankease/features/auth/data/remote/data_sources/users_remote_data_source.dart';
import 'package:bankease/features/auth/domain/failures.dart';
import 'package:bankease/features/auth/domain/repositories/auth_repo.dart';
import 'package:bankease/features/auth/domain/use_cases/register_use_case.dart';

class AuthRepoImpl implements AuthRepo {
  final UsersRemoteDataSource _usersRemoteDataSource;

  AuthRepoImpl(this._usersRemoteDataSource);

  @override
  UserEntity getLoggedUser() {
    final user = _usersRemoteDataSource.getLoggedUser();
    return UserEntity(
      id: user.uid,
      name: user.displayName ?? '',
      profilePicture: user.photoURL ?? '',
      email: user.email!,
    );
  }

  @override
  Future<Either<AuthFailure, UserEntity>> login(
      EmailAddress emailAddress, Password password) async {
    try {
      await _usersRemoteDataSource.login(
          emailAddress.getOrCrash(), password.getOrCrash());
      return const Right(
          UserEntity(id: '', name: '', email: '', profilePicture: ''));
    } on AuthException catch (e) {
      if (e is InvalidEmailException) {
        return Left(InvalidEmailFailure());
      } else if (e is WrongPasswordException) {
        return Left(WrongPasswordFailure());
      } else if (e is UserNotFoundException) {
        return Left(UserNotFoundFailure());
      } else if (e is UserDisabledException) {
        return Left(UserDisabledFailure());
      } else if (e is TooManyRequestException) {
        return Left(TooManyRequestFailure());
      } else {
        return Left(UnexpectedFailure());
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserEntity> getUserInfo() async {
    final id = getLoggedUser().id;
    final result = await _usersRemoteDataSource.getOne(id);
    return UserEntity(
      id: result!.id,
      name: result.name,
      profilePicture: result.profilePicture,
      email: result.email,
    );
  }

  @override
  Future<Either<AuthFailure, Unit>> register(
      RegisterParams registerParams) async {
    try {
      await _usersRemoteDataSource.register(
          registerParams.fullName,
          registerParams.emailAddress.getOrCrash(),
          registerParams.password.getOrCrash());

      return right(unit);
    } on AuthException catch (e) {
      if (e is EmailAlreadyInUseException) {
        return Left((EmailAlreadyInUseFailure()));
      } else if (e is InvalidEmailException) {
        return Left(InvalidEmailFailure());
      } else if (e is WeakPasswordException) {
        return Left(WeakPasswordFailure());
      } else {
        return Left(UnexpectedFailure());
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> logout() async {
    return await _usersRemoteDataSource.logout();
  }
}
