import 'package:dartz/dartz.dart';
import 'package:spotswap/core/errors/errors.dart';
import 'package:spotswap/domain/entities/playlist_entity.dart';
import 'package:spotswap/domain/entities/profile_entity.dart';
import 'package:spotswap/domain/entities/token_entity.dart';

abstract class Repository {
  Future<Either<Failure, Token>> authentication(String code);
  Future<Either<Failure, Profile>> getProfile();
  Future<Either<Failure, List<PlayList>>> getUserPlaylists(String userId);
}
