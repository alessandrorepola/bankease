import 'package:bankease/features/auth/domain/repositories/auth_repo.dart';
import 'package:flutter/material.dart';
import 'package:bankease/core/domain/entities/user_entity.dart';
import 'package:bankease/core/injection.dart';
import 'package:bankease/core/use_case/use_case.dart';
import 'package:bankease/features/auth/domain/use_cases/logout_use_case.dart';
import 'package:bankease/features/profile/domain/use_cases/get_profile_use_case.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final profileProvider =
    ChangeNotifierProvider.autoDispose<ProfileProvider>((ref) {
  return ProfileProvider(
    GetProfileUseCase(sl<AuthRepo>()),
    LogoutUseCase(sl<AuthRepo>()),
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
