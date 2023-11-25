import 'package:dartz/dartz.dart';
import 'package:spotswap/core/errors/errors.dart';
import 'package:spotswap/core/utils/usecase.dart';
import 'package:spotswap/domain/entities/track_entity.dart';
import 'package:spotswap/domain/repository/repository.dart';

class GetMyTracksUseCase extends UseCase<List<Track>, NoParams> {
  GetMyTracksUseCase({required this.repository});

  final Repository repository;
  @override
  Future<Either<Failure, List<Track>>> call(params) => repository.getMyTracks();
}
