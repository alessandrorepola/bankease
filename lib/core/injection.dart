import 'package:bankease/core/services/local_notification_service/local_notification_service.dart';
import 'package:bankease/features/auth/domain/repositories/auth_repo.dart';
import 'package:bankease/features/requests/data/remote/data_sources/requests_remote_data_source.dart';
import 'package:bankease/features/requests/data/repositories/branches_repo_impl.dart';
import 'package:bankease/features/requests/data/repositories/requests_repo_impl.dart';
import 'package:bankease/features/requests/domain/repositories/requests_repo.dart';
import 'package:bankease/features/requests/domain/use_cases/load_requests_use_case.dart';
import 'package:bankease/features/requests/presentation/manager/requests_bloc/requests_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:bankease/core/app_routes.dart';
import 'package:bankease/core/local_data_source_initializer.dart';
import 'package:bankease/features/auth/data/remote/data_sources/users_remote_data_source.dart';
import 'package:bankease/features/auth/data/repositories/auth_repo_impl.dart';
import 'package:bankease/features/auth/domain/use_cases/login_use_case.dart';
import 'package:bankease/features/auth/domain/use_cases/register_use_case.dart';
import 'package:bankease/features/auth/presentation/manager/login_bloc/login_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:sqflite/sqflite.dart';

import '../features/auth/presentation/manager/register_bloc/register_bloc.dart';

class Injection {
  static final getIt = GetIt.instance;

  static setup() async {
    openDatabase('path');
    final LocalDataSourceInitializer localDataSourceInitializer =
        LocalDataSourceInitializer();
    await localDataSourceInitializer.openDatabaseConnection();
    getIt.registerSingleton<Database>(localDataSourceInitializer.database);
    getIt.registerSingleton<FirebaseAuth>(FirebaseAuth.instance);
    getIt.registerSingleton<AppRoutes>(AppRoutes(getIt.get<FirebaseAuth>()));
    getIt.registerSingleton<LocalNotificationService>(
        LocalNotificationService());

    getIt.registerSingleton<AuthRepo>(
      AuthRepoImpl(UsersRemoteDataSource(getIt.get<FirebaseAuth>()),
          getIt.get<FirebaseAuth>()),
    );
    getIt.registerLazySingleton<RequestsRepo>(
      () => RequestsRepoImpl(
          RequestsRemoteDataSource(),
          // NetworkInfoImpl(InternetConnectionChecker()),
          getIt.get<AuthRepo>(),
          BranchesRepoImpl()),
    );
    getIt.registerFactory<RequestsBloc>(
        () => RequestsBloc(LoadRequestsUseCase(getIt.get<RequestsRepo>())));
    getIt.registerFactory<RegisterBloc>(() => RegisterBloc(RegisterUseCase(
          getIt.get<AuthRepo>(),
        )));

    getIt.registerFactory<LoginBloc>(() => LoginBloc(LoginUseCase(
          getIt.get<AuthRepo>(),
        )));
  }
}
