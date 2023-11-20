import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:spotswap/core/consts/consts.dart';
import 'package:spotswap/core/services/http_service.dart';
import 'package:spotswap/data/datasource/network_datasource.dart';
import 'package:spotswap/data/repository/repository.dart';
import 'package:spotswap/domain/repository/repository.dart';

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
}
