import 'package:dartz/dartz.dart';
import 'package:spotswap/core/errors/errors.dart';
import 'package:spotswap/core/errors/exceptions.dart';
import 'package:spotswap/core/services/connection_checker.dart';
import 'package:spotswap/data/datasource/network_datasource.dart';
import 'package:spotswap/domain/entities/playlist_entity.dart';
import 'package:spotswap/domain/entities/profile_entity.dart';
import 'package:spotswap/domain/entities/token_entity.dart';
import 'package:spotswap/domain/repository/repository.dart';

class RepositoryImpl implements Repository {
  const RepositoryImpl({
    required this.networkDatasource,
    required this.networkInfo,
  });

  final NetworkDatasource networkDatasource;
  final NetworkInfo networkInfo;
  @override
  Future<Either<Failure, Token>> authentication(String code) async {
    try {
      if (await networkInfo.hasConnection!) {
        final result = await networkDatasource.authentication(code);
        await networkDatasource.setToken(result);
        return Right(result);
      } else {
        return const Left(NetworkFailure(message: 'No Internet'));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, Profile>> getProfile() async {
    try {
      if (await networkInfo.hasConnection!) {
        final result = await networkDatasource.getProfile();
        return Right(result);
      } else {
        return const Left(NetworkFailure(message: 'No Internet'));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, List<PlayList>>> getUserPlaylists(
    String userId,
  ) async {
    try {
      if (await networkInfo.hasConnection!) {
        final result = await networkDatasource.getUserPlaylists(userId);
        return Right(result);
      } else {
        return const Left(NetworkFailure(message: 'No Internet'));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }
}
