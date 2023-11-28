import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:spotswap/core/consts/consts.dart';
import 'package:spotswap/core/services/connection_checker.dart';
import 'package:spotswap/core/services/http_service.dart';
import 'package:spotswap/data/datasource/local_datasource.dart';
import 'package:spotswap/data/datasource/network_datasource.dart';
import 'package:spotswap/data/repository/repository.dart';
import 'package:spotswap/domain/entities/track_entity.dart';
import 'package:spotswap/domain/repository/repository.dart';
import 'package:spotswap/domain/usecases/authentication_usecase.dart';
import 'package:spotswap/domain/usecases/export_tracks_usecase.dart';
import 'package:spotswap/domain/usecases/get_my_tracks_usecase.dart';
import 'package:spotswap/domain/usecases/get_profile_usecase.dart';
import 'package:spotswap/domain/usecases/get_user_playlists_usecase.dart';
import 'package:spotswap/domain/usecases/load_my_tracks_usecase.dart';
import 'package:spotswap/presentation/bloc/spotswap_bloc.dart';

final sl = GetIt.instance;
Future<void> init() async {
  final directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(TrackAdapter()); //1
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
  sl.registerLazySingleton<LocalDatasource>(
    () => LocalDatasourceImpl(),
  );
  //repository
  sl.registerLazySingleton<Repository>(
    () => RepositoryImpl(
      networkDatasource: sl(),
      localDatasource: sl(),
      networkInfo: sl(),
    ),
  );
  //usecase
  sl.registerLazySingleton(
    () => AuthenticationUseCase(repository: sl()),
  );
  sl.registerLazySingleton(
    () => GetProfileUseCase(repository: sl()),
  );
  sl.registerLazySingleton(
    () => GetUserPlayListsUseCase(repository: sl()),
  );
  sl.registerLazySingleton(
    () => GetMyTracksUseCase(repository: sl()),
  );
  sl.registerLazySingleton(
    () => ExportTracksUseCase(repository: sl()),
  );
  sl.registerLazySingleton(
    () => LoadMyTracksUseCase(repository: sl()),
  );
  //bloc
  sl.registerLazySingleton(
    () => SpotSwapBloc(
      authenticationUseCase: sl(),
      getProfileUseCase: sl(),
      getUserPlayListsUseCase: sl(),
      getMyTracksUseCase: sl(),
      exportTracksUseCase: sl(),
      loadMyTracksUseCase: sl(),
    ),
  );
}
