import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:requests_inspector/requests_inspector.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasks/core/feature/data/datasources/local_data_source.dart';
import 'package:tasks/core/feature/data/datasources/remote_data_source.dart';
import 'package:tasks/core/feature/data/repositories/repository_imp.dart';
import 'package:tasks/core/feature/domain/repositories/repositories.dart';
import 'package:tasks/core/network/network.dart';
import 'package:tasks/features/login/domain/usecases/usecases.dart';
import 'package:tasks/features/login/presentation/cubit.dart';
import 'package:tasks/features/home/presentation/cubit/cubit.dart';
import 'package:tasks/features/home/usecases/usecases.dart';

import 'network/network_info.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - posts
  // Bloc
  // need this cubit to be the same across the app
  sl.registerLazySingleton(() => HomeCubit(useCase: sl()));
  sl.registerLazySingleton(() => LoginCubit(useCase: sl()));

  // Usecases
  sl.registerLazySingleton(() => TaskUseCase(repository: sl()));
  sl.registerLazySingleton(() => AuthUseCase(repository: sl()));

  // Repository
  sl.registerLazySingleton<Repository>(
      () => RepoImp(remoteDataSource: sl(), localDataSource: sl()));

  // Datasources
  sl.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSource(network: sl(), networkInfo: sl()));
  sl.registerLazySingleton<LocalDataSource>(
      () => LocalDataSourceImpl(box: sl()));

  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton<Network>(() => Network(dio: sl(), box: sl()));

  //! External
  sl.registerLazySingletonAsync(
      () async => await SharedPreferences.getInstance());
  await sl.isReady<SharedPreferences>();
  sl.registerLazySingleton(() => InternetConnectionChecker());
  sl.registerLazySingleton(() => Dio(BaseOptions(
      connectTimeout: const Duration(seconds: 1000),
      receiveTimeout: const Duration(seconds: 1000),
      validateStatus: (_) => true))
    ..interceptors.add(RequestsInspectorInterceptor()));
}
