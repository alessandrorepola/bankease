import 'package:flutter/material.dart';
import 'package:bankease/core/domain/entities/user_entity.dart';
import 'package:bankease/core/injection.dart';
import 'package:bankease/core/use_case/use_case.dart';
import 'package:bankease/features/auth/data/repositories/auth_repo_impl.dart';
import 'package:bankease/features/auth/domain/use_cases/logout_use_case.dart';
import 'package:bankease/features/profile/domain/use_cases/get_profile_use_case.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final profileProvider =
    ChangeNotifierProvider.autoDispose<ProfileProvider>((ref) {
  return ProfileProvider(
    GetProfileUseCase(Injection.getIt.get<AuthRepoImpl>()),
    LogoutUseCase(Injection.getIt.get<AuthRepoImpl>()),
  );
});

class ProfileProvider extends ChangeNotifier {
  ProfileProvider(
    this.getProfileUseCase,
    this.logoutUseCase,
  ) {
    userEntity = getProfileUseCase.call(NoParams());
  }

  final GetProfileUseCase getProfileUseCase;
  final LogoutUseCase logoutUseCase;

  late final UserEntity userEntity;

  // logout
  Future<void> logout() async {
    await logoutUseCase.call(NoParams());
  }
}
