import 'package:bankease/core/services/local_notification_service/local_notification_service.dart';
import 'package:bankease/features/auth/domain/repositories/auth_repo.dart';
import 'package:bankease/features/requests/data/remote/data_sources/requests_remote_data_source.dart';
import 'package:bankease/features/requests/data/repositories/branches_repo_impl.dart';
import 'package:bankease/features/requests/data/repositories/requests_repo_impl.dart';
import 'package:bankease/features/requests/domain/repositories/requests_repo.dart';
import 'package:bankease/features/requests/domain/use_cases/delete_request_use_case.dart';
import 'package:bankease/features/requests/domain/use_cases/undo_delete_request_use_case.dart';
import 'package:bankease/features/requests/presentation/manager/requests_bloc/requests_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:bankease/core/app_routes.dart';
import 'package:bankease/features/auth/data/remote/data_sources/users_remote_data_source.dart';
import 'package:bankease/features/auth/data/repositories/auth_repo_impl.dart';
import 'package:bankease/features/auth/domain/use_cases/login_use_case.dart';
import 'package:bankease/features/auth/domain/use_cases/register_use_case.dart';
import 'package:bankease/features/auth/presentation/manager/login_bloc/login_bloc.dart';
import 'package:get_it/get_it.dart';

import '../features/auth/presentation/manager/register_bloc/register_bloc.dart';

final sl = GetIt.instance;

class Injection {
  static setup() async {
    // Dependecies
    sl.registerSingleton<FirebaseAuth>(FirebaseAuth.instance);

    // Services
    sl.registerSingleton<AppRoutes>(AppRoutes(sl<FirebaseAuth>()));
    sl.registerSingleton<LocalNotificationService>(LocalNotificationService());

    // Repos
    sl.registerSingleton<AuthRepo>(
      AuthRepoImpl(UsersRemoteDataSource(sl<FirebaseAuth>())),
    );
    sl.registerLazySingleton<RequestsRepo>(
      () => RequestsRepoImpl(RequestsRemoteDataSource(sl<FirebaseAuth>()),
          sl<AuthRepo>(), BranchesRepoImpl()),
    );

    // Blocs
    sl.registerFactory<RequestsBloc>(
      () => RequestsBloc(
        DeleteRequestUseCase(sl<RequestsRepo>()),
        UndoDeleteRequestUseCase(sl<RequestsRepo>()),
        requestsRepo: sl<RequestsRepo>(),
      ),
    );
    sl.registerFactory<RegisterBloc>(
      () => RegisterBloc(
        RegisterUseCase(
          sl<AuthRepo>(),
        ),
      ),
    );

    sl.registerFactory<LoginBloc>(
      () => LoginBloc(
        LoginUseCase(
          sl<AuthRepo>(),
        ),
      ),
    );
  }
}
