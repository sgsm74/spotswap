import 'package:dartz/dartz.dart';
import 'package:spotswap/core/errors/errors.dart';
import 'package:spotswap/core/services/connection_checker.dart';
import 'package:spotswap/data/datasource/network_datasource.dart';
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
  Future<Either<Failure, Token>> authentication() {
    // TODO: implement authentication
    throw UnimplementedError();
  }
}
