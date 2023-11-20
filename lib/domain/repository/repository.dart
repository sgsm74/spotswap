import 'package:dartz/dartz.dart';
import 'package:spotswap/core/errors/errors.dart';
import 'package:spotswap/domain/entities/token_entity.dart';

abstract class Repository {
  Future<Either<Failure, Token>> authentication();
}
