import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:spotswap/core/consts/consts.dart';
import 'package:spotswap/core/services/connection_checker.dart';
import 'package:spotswap/core/services/http_service.dart';
import 'package:spotswap/data/datasource/network_datasource.dart';
import 'package:spotswap/data/repository/repository.dart';
import 'package:spotswap/domain/repository/repository.dart';
import 'package:spotswap/domain/usecases/authentication_usecase.dart';
import 'package:spotswap/presentation/provider/spot_swap_model.dart';

final sl = GetIt.instance;
Future<void> init() async {
  //http service
  sl.registerLazySingleton<HTTPService>(
    () => DioService(
      dio: Dio(
        BaseOptions(
          baseUrl: ServerPaths.baseUrl,
        ),
      ),
    ),
  );
  //network
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(dataConnectionChecker: sl()),
  );
  //connection checker
  sl.registerLazySingleton(
    () => InternetConnectionChecker.createInstance(
      checkTimeout: const Duration(milliseconds: 90),
    ),
  );
  //datasource
  sl.registerLazySingleton<NetworkDatasource>(
    () => NetworkDatasourceImpl(
      http: sl(),
    ),
  );
  //repository
  sl.registerLazySingleton<Repository>(
    () => RepositoryImpl(
      networkDatasource: sl(),
      networkInfo: sl(),
    ),
  );
  //usecase
  sl.registerLazySingleton(
    () => AuthenticationUseCase(repository: sl()),
  );
  //provider
  sl.registerLazySingleton(
    () => SpotSwapModel(authenticationUseCase: sl()),
  );
}
