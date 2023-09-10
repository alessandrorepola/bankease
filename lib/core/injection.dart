import 'package:bankease/features/requests/data/remote/data_sources/branches_remote_data_source.dart';
import 'package:bankease/features/requests/data/remote/data_sources/requests_remote_data_source.dart';
import 'package:bankease/features/requests/data/repositories/branches_repo_impl.dart';
import 'package:bankease/features/requests/data/repositories/requests_repo_impl.dart';
import 'package:bankease/features/requests/domain/repositories/branches_repo.dart';
import 'package:bankease/features/requests/domain/use_cases/load_requests_use_case.dart';
import 'package:bankease/features/requests/presentation/manager/requests_bloc/requests_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
// import 'package:firebase_storage/firebase_storage.dart';
import 'package:bankease/core/app_routes.dart';
// import 'package:bankease/core/custom_firestorage.dart';
import 'package:bankease/core/local_data_source_initializer.dart';
import 'package:bankease/core/network/network_info.dart';
import 'package:bankease/features/auth/data/remote/data_sources/users_remote_data_source.dart';
import 'package:bankease/features/auth/data/repositories/auth_repo_impl.dart';
import 'package:bankease/features/auth/domain/use_cases/login_use_case.dart';
import 'package:bankease/features/auth/domain/use_cases/register_use_case.dart';
import 'package:bankease/features/auth/presentation/manager/login_bloc/login_bloc.dart';
// import 'package:bankease/features/requests/data/local/data_sources/requests_local_data_source.dart';
// import 'package:bankease/features/requests/data/remote/data_sources/requests_remote_data_source.dart';
// import 'package:bankease/features/requests/data/repositories/requests_repo.dart';
// import 'package:bankease/features/requests/domain/use_cases/load_requests_use_case.dart';
// import 'package:bankease/features/requests/presentation/manager/requests_bloc/requests_bloc.dart';
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
    final firebaseAuth = getIt.get<FirebaseAuth>();
    getIt.registerSingleton<AppRoutes>(AppRoutes(firebaseAuth));

    getIt.registerSingleton<AuthRepoImpl>(
      AuthRepoImpl(UsersRemoteDataSource(getIt.get<FirebaseAuth>()),
          getIt.get<FirebaseAuth>()),
    );
    getIt.registerLazySingleton(
      () => RequestsRepoImpl(
          RequestsRemoteDataSource(),
          NetworkInfoImpl(InternetConnectionChecker()),
          getIt.get<AuthRepoImpl>(),
          BranchesRepoImpl()),
    );
    getIt.registerFactory<RequestsBloc>(
        () => RequestsBloc(LoadRequestsUseCase(getIt.get<RequestsRepoImpl>())));
    getIt.registerFactory<RegisterBloc>(() => RegisterBloc(RegisterUseCase(
          getIt.get<AuthRepoImpl>(),
        )));

    getIt.registerFactory<LoginBloc>(() => LoginBloc(LoginUseCase(
          getIt.get<AuthRepoImpl>(),
        )));
  }
}
