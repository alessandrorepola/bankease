import 'package:bankease/core/use_case/use_case.dart';
import 'package:bankease/features/auth/domain/repositories/auth_repo.dart';

class LogoutUseCase implements UseCase<void, NoParams> {
  final AuthRepo authRepo;

  LogoutUseCase(this.authRepo);

  @override
  Future<void> call(NoParams noParams) {
    return authRepo.logout();
  }
}
