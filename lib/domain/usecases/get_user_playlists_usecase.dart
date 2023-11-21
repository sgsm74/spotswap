import 'package:dartz/dartz.dart';
import 'package:spotswap/core/errors/errors.dart';
import 'package:spotswap/core/utils/usecase.dart';
import 'package:spotswap/domain/entities/playlist_entity.dart';
import 'package:spotswap/domain/repository/repository.dart';

class GetUserPlayListsUseCase extends UseCase<List<PlayList>, String> {
  GetUserPlayListsUseCase({required this.repository});

  final Repository repository;
  @override
  Future<Either<Failure, List<PlayList>>> call(String params) =>
      repository.getUserPlaylists(params);
}
